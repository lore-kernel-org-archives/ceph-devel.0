From: Sage Weil <sage@newdream.net>
Subject: Re: An empty vptr in an raw object
Date: Thu, 22 Dec 2016 18:41:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612221840330.10615@piezo.novalocal>
References: <4aeb9ff1-367c-f31e-fc0c-5f08dcdcfe0e@digiware.nl> <7754eadf-5f8c-ade3-1634-486fff240adf@digiware.nl> <EB02EE10422E4A40A1EE787A4AC27FBE044D2A@ULS-OP-MBXIP02.sdcorp.global.sandisk.com> <e1bdab0b-ec02-819e-e6fe-4e07baa235be@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44719 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966554AbcLVSlm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2016 13:41:42 -0500
In-Reply-To: <e1bdab0b-ec02-819e-e6fe-4e07baa235be@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

Oh.. if unittest_desc is the only culprit, it is probably easier to find.  
Which test case fails?  Do you have a full backtrace?

sage



On Thu, 22 Dec 2016, Willem Jan Withagen wrote:

> On 22-12-2016 19:02, Allen Samuels wrote:
> > I have seen cases of null vptr due to an incompletely constructed object, i.e., an object that's in the middle of being constructed. 
> 
> I going to believe you right away.
> But I'm having a hard time imagining such a case.
> 
> Are you suggesting a object is referenced, whilest it is not yet
> complete. who does the referencing then? due to threading?
> That would be even harder to find.
> 
> --WjW
> 
> 
> > Allen Samuels
> > SanDisk |a Western Digital brand
> > 951 SanDisk Drive, Milpitas, CA 95035
> > T: +1 408 801 7030| M: +1 408 780 6416
> > allen.samuels@SanDisk.com
> > 
> > 
> >> -----Original Message-----
> >> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> >> owner@vger.kernel.org] On Behalf Of Willem Jan Withagen
> >> Sent: Thursday, December 22, 2016 9:41 AM
> >> To: Ceph Development <ceph-devel@vger.kernel.org>
> >> Subject: An empty vptr in an raw object
> >>
> >>> I have a piece of code that actually seem to crash because the vptr is
> >>> not set:
> >>> (gdb) p *_raw
> >>> $2 = {_vptr$raw = 0x0, data = 0x10cc000 "\003", len = 72, nref = {val =
> >>> 1}, crc_spinlock = 0, crc_map = {__tree_ = {
> >>>       __begin_node_ = 0x10cc078,
> >>>       __pair1_ =
> >>>
> >> {<std::__1::__libcpp_compressed_pair_imp<std::__1::__tree_end_node<st
> >> d::__1::__tree_node_base<void*>*>,
> >>>
> >> std::__1::allocator<std::__1::__tree_node<std::__1::__value_type<std::__1
> >> ::pair<unsigned
> >>> long, unsigned long>, std::__1::pair<unsigned int, unsigned int> >,
> >>> void*> >, 2>> =
> >>>
> >> {<std::__1::allocator<std::__1::__tree_node<std::__1::__value_type<std::_
> >> _1::pair<unsigned
> >>> long, unsigned long>, std::__1::pair<unsigned int, unsigned int> >,
> >>> void*> >> = {<No data fields>}, __first_ = {
> >>>             __left_ = 0x0}}, <No data fields>},
> >>>
> >>> The function that crashes:
> >>>  char *buffer::ptr::c_str() {
> >>>     assert(_raw);
> >>>     if (buffer_track_c_str)
> >>>       buffer_c_str_accesses.inc();
> >>>     char *p =  _raw->get_data();
> >>>     return p + _off;
> >>>   }
> >>>
> >>> And crash is actually on the return line.
> >>>
> >>> Any ideas as how the vptr can be empty?
> >>
> >> Now the _vptr$raw point is part of the internal code of the clang class
> >> function table/constructor. Overwriting that means that class-function
> >> references are problematic to say the least. (in this example get_data()).
> >>
> >> The major reason why this occurs is because an object is being zeroed in
> >> C-style way: memset( &obj, 0, sizeof(obj))
> >> And thus overwriting the _vptr.
> >>
> >> Note that this does not bite the FreeBSD compilation, but also any other
> >> attempts to build Ceph with clang.
> >>
> >> Now the strange thing is that this does not bite Clang compilation much
> >> more. But the only test that fails is unittest_denc. So I guess that
> >> most of the code is rather well behaved.
> >>
> >> And I'm off on a search to find the culprit.
> >>
> >> --WjW
> >>
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
