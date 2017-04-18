From: Sage Weil <sage@newdream.net>
Subject: Re: Filestore directory splitting (ZFS/FreeBSD)
Date: Tue, 18 Apr 2017 13:27:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704181324240.6575@piezo.novalocal>
References: <bc464b95-08f7-d627-df00-00e9200ff259@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57850 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdDRN1D (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Apr 2017 09:27:03 -0400
In-Reply-To: <bc464b95-08f7-d627-df00-00e9200ff259@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 18 Apr 2017, Willem Jan Withagen wrote:
> Hi,
> 
> I'm running some alrger tests with ceph-fuse on FreeBSD, and noticed
> that I start to run into directory splitting I think?
> I just Rsynced my full src and ports tree into it, which is like >
> 1.000.000 small files.
> At least I saw a rather large number of directories with relatively few
> files in them.
> 
> I know from UFS that large directories used to be a problem, although
> some of the issues on FreeBSD have been fixed long ago.
> 
> So can anybody explain the rationale behind this process and give a bit
> of a feeling why we start splitting at 320 files??

It actually has little to do with the underlying file system's ability to 
handle large directories.  Ceph needs to do object enumeration in sorted 
order (based on the [g]hobject_t sort order) and readdir return entries in 
a semi-random order based on how the fs is implemented.  We keep 
directories smallish so that we can list the whole directory, sort in 
memory, and then return the correct result.

sage


> FreeBSD's filestore runs of ZFS, and From waht I've seen thusfar is that
> ZFS has a different (better) behaviour with large directories.
> (I once ended up with > 1.000.000 security cam pictures in one
> directory, and that still was sort of workable.)
> 
> So has there been any testing to quatify the settings? And how would I
> be able to determine if ZFS deserves better/larger settings?
> 
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
