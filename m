From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Fix overflow in FileJournal::_open_file()
Date: Thu, 9 Dec 2010 13:53:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012091353100.29614@cobra.newdream.net>
References: <20101209185322.GD21271@daedalus.cslab.ece.ntua.gr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35442 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab0LIVsR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Dec 2010 16:48:17 -0500
In-Reply-To: <20101209185322.GD21271@daedalus.cslab.ece.ntua.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vangelis Koukis <vkoukis@cslab.ece.ntua.gr>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

sage


On Thu, 9 Dec 2010, Vangelis Koukis wrote:

> Running the unstable branch, mkcephfs fails when trying to create
> a 3GB journal file on the OSDs.
> 
> Relevant messages from the osd logfile:
> 
> 2010-12-09 19:03:54.419737 7fdde4d51720 journal _open_file: unable to extend journal to 18446744072560312320 bytes
> 2010-12-09 19:03:54.419789 7fdde4d51720 filestore(/osd) mkjournal error creating journal on /osd/journal
> 
> The problem is that the calculation of the journal size in bytes
> overflows, in FileJournal::_open_file().
> 
> Signed-off-by: Vangelis Koukis <vkoukis@cslab.ece.ntua.gr>
> 
> ---
>  src/os/FileJournal.cc |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/os/FileJournal.cc b/src/os/FileJournal.cc
> index 3bb38a8..cd0808f 100644
> --- a/src/os/FileJournal.cc
> +++ b/src/os/FileJournal.cc
> @@ -223,7 +223,7 @@ int FileJournal::_open_file(int64_t oldsize, blksize_t blksize,
>    }
> 
>    if (create && (oldsize < conf_journal_sz)) {
> -    uint64_t newsize = g_conf.osd_journal_size << 20;
> +    uint64_t newsize = (uint64_t)g_conf.osd_journal_size << 20;
>      dout(10) << "_open extending to " << newsize << " bytes" << dendl;
>      ret = ::ftruncate(fd, newsize);
>      if (ret < 0) {
> --
> 1.7.2.3
> 
> -- 
> Vangelis Koukis
> vkoukis@cslab.ece.ntua.gr
> OpenPGP public key ID:
> pub  1024D/1D038E97 2003-07-13 Vangelis Koukis <vkoukis@cslab.ece.ntua.gr>
>      Key fingerprint = C5CD E02E 2C78 7C10 8A00  53D8 FBFC 3799 1D03 8E97
> 
> Our greatest glory is not in never failing,
> but in rising up every time we fail.
>         -- Ralph Waldo Emerson
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
