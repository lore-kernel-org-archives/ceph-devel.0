From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Ceph: allocate non-zero page to fscache
	in readpage()
Date: Sun, 10 Nov 2013 05:52:30 +0800
Message-ID: <08e1e1e7-0187-4ef5-8019-c99b9d7c90a7@email.android.com>
References: <1383963966-10888-1-git-send-email-liwang@ubuntukylin.com>
	<CANP1eJHthD-Q_Xv=HPWQjsJTHvpP2fj-X_j7HgBXaz5YKQ2EAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <CANP1eJHthD-Q_Xv=HPWQjsJTHvpP2fj-X_j7HgBXaz5YKQ2EAQ@mail.gmail.com>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: Milosz Tanski <milosz@adfin.com>, Li Wang <liwang@ubuntukylin.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, Sage Weil <sage@inktank.com>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Added to the testing branch.

Thanks!

Milosz Tanski <milosz@adfin.com> wrote:
>Li, that's a good good catch.
>
>
>On Fri, Nov 8, 2013 at 9:26 PM, Li Wang <liwang@ubuntukylin.com> wrote:
>> ceph_osdc_readpages() returns number of bytes read, currently,
>> the code only allocate full-zero page into fscache, this patch
>> fixes this.
>>
>> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
>> ---
>>  fs/ceph/addr.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index 6df8bd4..1e561c0 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -216,7 +216,7 @@ static int readpage_nounlock(struct file *filp,
>struct page *page)
>>         }
>>         SetPageUptodate(page);
>>
>> -       if (err == 0)
>> +       if (err >= 0)
>>                 ceph_readpage_to_fscache(inode, page);
>>
>>  out:
>> --
>> 1.7.9.5
>>
>
>
>
>-- 
>Milosz Tanski
>CTO
>10 East 53rd Street, 37th floor
>New York, NY 10022
>
>p: 646-253-9055
>e: milosz@adfin.com
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
