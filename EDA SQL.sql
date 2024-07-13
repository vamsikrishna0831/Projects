## EDA
select * from layoffs_staging2;
select *  from layoffs_staging2
where  percentage_laid_off=1
order by funds_raised_millions desc
;
select company,location,sum(total_laid_off)
from layoffs_staging2
group by company,location
order by 3 desc;
select min(`date`),max(`date`)
from layoffs_staging2;
select industry ,sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc
;
select country ,sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc
;
select year(`date` ),sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc
;
select substring(`date`,1,7) as months,sum(total_laid_off) as layed
from layoffs_staging2
where substring(`date`,1,7) is not null
group by months
order by 1 asc
;
with rolling_table as
(
select substring(`date`,1,7) as months,sum(total_laid_off) as layed
from layoffs_staging2
where substring(`date`,1,7) is not null
group by months
order by 1 
)
select months,layed,sum(layed)over(order by months)  as rolling_table
from rolling_table
group by months ;
select substring(`date`,1,7) as months,sum(total_laid_off) as layed,country
from layoffs_staging2
where substring(`date`,1,7) is not null
group by months,country
order by 1 asc
;
select country,sum(total_laid_off) 
from layoffs_staging2
group by country
;
select company,year(`date`),sum(total_laid_off) 
from layoffs_staging2
group by company,year(`date`)
order by 3 desc
;
with ranking(company,years,total_laidoff) as
(
select company,year(`date`),sum(total_laid_off) 
from layoffs_staging2
group by company,year(`date`)
order by 3 desc
),company_rank as (
select * ,dense_rank() over (partition by years order by total_laidoff desc) as ranks
from ranking
where years is not null
)
select * from company_rank
where ranks<=5;