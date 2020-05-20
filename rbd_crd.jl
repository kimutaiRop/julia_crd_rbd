function main()

    #define the array
    arry = [
        20 16 26 26 34 28 20 18
        26 22 26 24 38 30 24 29
        32 28 32 24 36 48 36 24
        48 42 34 36 42 54 50 45
    ]
    treatments = []
    if size(treatments)[1] == 0
        treatments = [string("T", n) for n = 1:size(arry)[1]]
    end
    prob = 2
    if prob == 1
        crd(arry)
    elseif prob == 2
        rbd(arry)
    end
end

function calculate_basic(arry)
    treat_total = sum(arry, dims = 2)
    treatment_mean = treat_total ./ size(arry)[2]
    tratment_total_squared = treat_total .^ 2
    grand_total_observations = sum(arry)
    total_squared_observations = sum(arry .^ 2)
    N = size(arry)[1] * size(arry)[2]
    grand_mean_observations = grand_total_observations / N
    grand_total_squared = grand_total_observations^2
    return (
        treat_total,
        treatment_mean,
        tratment_total_squared,
        grand_total_observations,
        total_squared_observations,
        N,
        grand_mean_observations,
        grand_total_squared,
    )
end


function crd(arry, args...)
    k = size(arry)[1]
    treat_total,
    treatment_mean,
    tratment_total_squared,
    grand_total_observations,
    total_squared_observations,
    N,
    grand_mean_observations,
    grand_total_squared = calculate_basic(arry)

    SST = total_squared_observations - grand_total_squared / N
    MSST = SST / (N - 1)

    SSt = sum(tratment_total_squared ./ size(arry)[2]) - grand_total_squared / N
    MSSt = SSt / (k - 1)

    SSe = SST - SSt
    MSSe = SSe / (N - k)
    if length(args) > 0
        return (
            grand_total_observations,
            total_squared_observations,
            N,
            grand_mean_observations,
            grand_total_squared,
            k,
            MSST,
            SSt,
            MSSt,
            SST,
            MSST,
        )
    else
        show_anova(SSt, SSe, SST, MSSt, MSSe, MSST, N, k)
    end
end

function rbd(arry)
    b = size(arry)[2]
    grand_total_observations,
    total_squared_observations,
    N,
    grand_mean_observations,
    grand_total_squared,
    k,
    MSST,
    SSt,
    MSSt,
    SST,
    MSST = crd(arry, 1)
    block_total = sum(arry, dims = 1)
    block_mean = block_total ./ size(arry)[1]
    block_total_squared = block_total .^ 2
    SSb = sum(block_total_squared ./ size(arry)[1]) - grand_total_squared / N
    MSSb = SSb / (b - 1)
    SSe = SST - (SSt + SSb)
    MSSe = SSe / ((k - 1) * (b - 1))
    show_anova(SSt, SSe, SST, MSSt, MSSe, MSST, N, k, SSb, MSSb, b)
end

function show_anova(SSt, SSe, SST, MSSt, MSSe, MSST, N, k, args...)
    if length(args) === 0
        print("""

                                            ANOVA TABLE
            ____________________________________________________________________________________________
            SOURCE OF V             SS                  d.f                 MSS                 F
            ______________________________________________________________________________________________
            Treatment               $(round(SSt,digits=3))                 $(k-1)                $(round(MSSt,digits=3))             $(round(MSSt/MSSe,digits=3))
            Error                   $(round(SSe,digits=3))                $(N-k)                $(round(MSSe,digits=3))
            total                   $(round(SST,digits=3))                $(N)                $(round(MSST,digits=3))
        """)
    else
        SSb, MSSb, b = args
        print("""

                                            ANOVA TABLE
            ____________________________________________________________________________________________
            SOURCE OF V             SS                  d.f                 MSS                 F
            ______________________________________________________________________________________________
            Treatment               $(round(SSt,digits=3))                 $(k-1)                $(round(MSSt,digits=3))             $(round(MSSt/MSSe,digits=3))
            Blocks                  $(round(SSb,digits=3))                 $(b-1)                $(round(MSSb,digits=3))             $(round(MSSb/MSSe,digits=3))
            Error                   $(round(SSe,digits=3))                $((k-1)*(b-1))                $(round(MSSe,digits=3))
            total                   $(round(SST,digits=3))                $(N-1)                $(round(MSST,digits=3))
        """)
    end
end
main()
