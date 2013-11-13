From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: [PATCH] Ceph: Avoid data inconsistency due to d-cache aliasing
 in readpage()
Date: Wed, 13 Nov 2013 22:37:17 +0800
Message-ID: <52838E9D.7010901@ubuntukylin.com>
References: <1384327335-18812-1-git-send-email-liwang@ubuntukylin.com> <CAAM7YA=1DXyW+tr8CcAidOw_Hqmq=2o7QhcKGQO93n8jY5qAdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YA=1DXyW+tr8CcAidOw_Hqmq=2o7QhcKGQO93n8jY5qAdg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Yan,
   zero_user_segment() has invoked flush_dcache_page() for us, we donnot 
wanna flush d-cache twice.

Cheers,
Li Wang

On 11/13/2013 09:19 PM, Yan, Zheng wrote:
> On Wed, Nov 13, 2013 at 3:22 PM, Li Wang <liwang@ubuntukylin.com> wrote:
>> If the length of data to be read in readpage() is exactly
>> PAGE_CACHE_SIZE, the original code does not flush d-cache
>> for data consistency after finishing reading. This patches fixes
>> this.
>>
>> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
>> ---
>>   fs/ceph/addr.c |    8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index 6df8bd4..7b0000a 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -210,9 +210,13 @@ static int readpage_nounlock(struct file *filp, struct page *page)
>>          if (err < 0) {
>>                  SetPageError(page);
>>                  goto out;
>> -       } else if (err < PAGE_CACHE_SIZE) {
>> +       } else {
>> +               if (err < PAGE_CACHE_SIZE) {
>>                  /* zero fill remainder of page */
>> -               zero_user_segment(page, err, PAGE_CACHE_SIZE);
>> +                       zero_user_segment(page, err, PAGE_CACHE_SIZE);
>> +               } else {
>> +                       flush_dcache_page(page);
>> +               }
>
> this doesn't make sense for me. why not call flush_dcache_page unconditionally?
>
> Regards
> Yan, Zheng
>>          }
>>          SetPageUptodate(page);
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
