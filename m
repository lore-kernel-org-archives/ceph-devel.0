From: Sage Weil <sweil@redhat.com>
Subject: Re: Newstore inode usage
Date: Thu, 14 May 2015 14:17:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505141405400.10788@cobra.newdream.net>
References: <CACAg-u918c1mjDowLF8_14zW93uCOJNPy4oOw4pU=id0As=rHA@mail.gmail.com> <alpine.DEB.2.00.1505140909440.10788@cobra.newdream.net> <CACAg-u9HTj9EimoHiT4sCp2ByPtsyD_UGMSp3dq+tLv0mzwgwQ@mail.gmail.com> <alpine.DEB.2.00.1505141226160.10788@cobra.newdream.net>
 <CACAg-u8ke2GaqJL01+=LRvR0p_4ivqOa8pkXy6DxS+APL=Ccow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1092670622-1431638241=:10788"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49411 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964836AbbENVRY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 May 2015 17:17:24 -0400
In-Reply-To: <CACAg-u8ke2GaqJL01+=LRvR0p_4ivqOa8pkXy6DxS+APL=Ccow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Srikanth Madugundi <srikanth.madugundi@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1092670622-1431638241=:10788
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 May 2015, Srikanth Madugundi wrote:
> Adding ceph-devel
> Sage,
> 
> Do you have a timeline to support the feature to store multiple objects into
> one fragment?

No timeline for this... it isn't something I've thought about at all. It'd 
probably be multiple objects in one fid, though--the fragments would be 
non-overlapping.  Unless we wanted to do some deduping thing with 
shared fragments (where, say, you write the same content to multiple 
objects simultaneously).

sage


> 
> Regards
> Srikanth
> 
> On Thu, May 14, 2015 at 12:27 PM, Sage Weil <sweil@redhat.com> wrote:
>       On Thu, 14 May 2015, Srikanth Madugundi wrote:
>       > Thanks Sage for the details,
>       > As per your email mentioned in the newstore blueprint. 
>       >
>       > http://marc.info/?l=ceph-devel&m=142438985013041&w=2
> 
>       can we start ccing ceph-devel?
> 
>       > You have defined the following structures which has definition
>       to offset in
>       > the fragment and length of the fragment. Just wondering how
>       this is used. If
>       > each object is stored in one file why do we need offset in the
>       file and
>       > length.
>       >
>       > struct fragment_t {
>       >    uint32_t offset;   ///< offset in file to first byte of
>       this fragment
>       >    uint32_t length;   ///< length of fragment/extent
> 
>       Right now there's only 1 fragment per object, so offset is
>       always == 0.
>       That will eventually change (and read path can already handle
>       it).
> 
>       >    fid_t fid;         ///< file backing this fragment
>       >
>       > and fid_t is
>       >
>       >  struct fid_t {
>       >    uint32_t fset, fno;   // identify the file name:
>       fragments/%d/%d
> 
>       Yep
> 
>       sage
> 
>       >
>       >
>       > Regards
>       > Srikanth
>       >
>       >
>       > On Thu, May 14, 2015 at 9:11 AM, Sage Weil <sweil@redhat.com>
>       wrote:
>       >       On Thu, 14 May 2015, Srikanth Madugundi wrote:
>       >       > Hi Sage,
>       >       > I setup a test cluster with object store as "newstore
>       >       rocksdb", I noticed
>       >       > that the number of files creates are equal to the
>       number of
>       >       objects for
>       >       > objects of size 100K. Is this expected? As per the
>       blueprint
>       >       document you
>       >       > mentioned that multiple objects are packed into one
>       file under
>       >       > fragments/%d/%d.
>       >
>       >       It's expected.. I dont' remember talking about packing
>       multiple
>       >       object
>       >       sinto a single fragmetn.  We *do* plan to put a single
>       object
>       >       across
>       >       multiple fragments if it is big (to avoid
>       cost/complexity of
>       >       write-ahead for overwrite on large writes), but that
>       isn't
>       >       implemented yet.
>       >
>       >       > I ran another test with 10K size objects and noticed
>       that the
>       >       objects are
>       >       > stored under db/*.sst files. The objects are not
>       created under
>       >       fragments/
>       >       > directory for objects of size 10K.
>       >
>       >       db/ is rocksdb.  Small objects are exclusively there (by
>       >       default, you
>       >       can disable this with the newstore overlay settings).
>       >
>       >       > I plan to read through the newstore code but wanted to
>       check
>       >       with you what
>       >       > is the object size when newstore starts to aggregate
>       multiple
>       >       objects into
>       >       > single file? 
>       >
>       >       s
>       >
>       >       >
>       >       > Regards
>       >       > Srikanth
>       >       >
>       >       >
>       >       >
>       >       >
>       >
>       >
>       >
>       >
> 
> 
> 
> 
--557981400-1092670622-1431638241=:10788--
