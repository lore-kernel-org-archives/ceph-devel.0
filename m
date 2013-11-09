From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH] Ceph: allocate non-zero page to fscache in readpage()
Date: Sat, 9 Nov 2013 10:19:31 -0500
Message-ID: <CANP1eJHthD-Q_Xv=HPWQjsJTHvpP2fj-X_j7HgBXaz5YKQ2EAQ@mail.gmail.com>
References: <1383963966-10888-1-git-send-email-liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1383963966-10888-1-git-send-email-liwang@ubuntukylin.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, Sage Weil <sage@inktank.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Li, that's a good good catch.


On Fri, Nov 8, 2013 at 9:26 PM, Li Wang <liwang@ubuntukylin.com> wrote:
> ceph_osdc_readpages() returns number of bytes read, currently,
> the code only allocate full-zero page into fscache, this patch
> fixes this.
>
> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
> ---
>  fs/ceph/addr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 6df8bd4..1e561c0 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -216,7 +216,7 @@ static int readpage_nounlock(struct file *filp, struct page *page)
>         }
>         SetPageUptodate(page);
>
> -       if (err == 0)
> +       if (err >= 0)
>                 ceph_readpage_to_fscache(inode, page);
>
>  out:
> --
> 1.7.9.5
>



-- 
Milosz Tanski
CTO
10 East 53rd Street, 37th floor
New York, NY 10022

p: 646-253-9055
e: milosz@adfin.com
