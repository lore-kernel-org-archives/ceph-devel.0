From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH] os/FileJournal: Update the journal header when closing
 journal
Date: Wed, 23 Jul 2014 10:38:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407231037360.15853@cobra.newdream.net>
References: <6AA21C22F0A5DA478922644AD2EC308C895E17@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34707 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbaGWRi7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jul 2014 13:38:59 -0400
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C895E17@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Pushed this to wip-journal-header, see

	https://github.com/ceph/ceph/pull/2139

We'll run this through the regression suite before merging.

Thanks!
sage


On Wed, 23 Jul 2014, Ma, Jianpeng wrote:

> When closing journal, it should check must_write_header and update
> journal header if must_write_header alreay set.
> It can reduce the nosense journal-replay after restarting osd.
> 
> Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
> ---
>  src/os/FileJournal.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/os/FileJournal.cc b/src/os/FileJournal.cc
> index 7eb7927..5649e6d 100644
> --- a/src/os/FileJournal.cc
> +++ b/src/os/FileJournal.cc
> @@ -544,6 +544,7 @@ void FileJournal::close()
> 
>    // close
>    assert(writeq_empty());
> +  assert(!must_write_header);
>    assert(fd >= 0);
>    VOID_TEMP_FAILURE_RETRY(::close(fd));
>    fd = -1;
> @@ -1102,7 +1103,7 @@ void FileJournal::write_thread_entry()
>    while (1) {
>      {
>        Mutex::Locker locker(writeq_lock);
> -      if (writeq.empty()) {
> +      if (writeq.empty() && !must_write_header) {
>         if (write_stop)
>           break;
>         dout(20) << "write_thread_entry going to sleep" << dendl;
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
