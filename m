From: Willem Jan Withagen <wjw@digiware.nl>
Subject: An empty vptr in an raw object
Date: Thu, 22 Dec 2016 18:41:04 +0100
Message-ID: <7754eadf-5f8c-ade3-1634-486fff240adf@digiware.nl>
References: <4aeb9ff1-367c-f31e-fc0c-5f08dcdcfe0e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:39925 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938966AbcLVRlL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Dec 2016 12:41:11 -0500
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 99D873396A
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2016 18:41:06 +0100 (CET)
In-Reply-To: <4aeb9ff1-367c-f31e-fc0c-5f08dcdcfe0e@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

> I have a piece of code that actually seem to crash because the vptr is
> not set:
> (gdb) p *_raw
> $2 = {_vptr$raw = 0x0, data = 0x10cc000 "\003", len = 72, nref = {val =
> 1}, crc_spinlock = 0, crc_map = {__tree_ = {
>       __begin_node_ = 0x10cc078,
>       __pair1_ =
> {<std::__1::__libcpp_compressed_pair_imp<std::__1::__tree_end_node<std::__1::__tree_node_base<void*>*>,
> std::__1::allocator<std::__1::__tree_node<std::__1::__value_type<std::__1::pair<unsigned
> long, unsigned long>, std::__1::pair<unsigned int, unsigned int> >,
> void*> >, 2>> =
> {<std::__1::allocator<std::__1::__tree_node<std::__1::__value_type<std::__1::pair<unsigned
> long, unsigned long>, std::__1::pair<unsigned int, unsigned int> >,
> void*> >> = {<No data fields>}, __first_ = {
>             __left_ = 0x0}}, <No data fields>},
> 
> The function that crashes:
>  char *buffer::ptr::c_str() {
>     assert(_raw);
>     if (buffer_track_c_str)
>       buffer_c_str_accesses.inc();
>     char *p =  _raw->get_data();
>     return p + _off;
>   }
> 
> And crash is actually on the return line.
> 
> Any ideas as how the vptr can be empty?

Now the _vptr$raw point is part of the internal code of the clang class
function table/constructor. Overwriting that means that class-function
references are problematic to say the least. (in this example get_data()).

The major reason why this occurs is because an object is being zeroed in
C-style way: memset( &obj, 0, sizeof(obj))
And thus overwriting the _vptr.

Note that this does not bite the FreeBSD compilation, but also any other
attempts to build Ceph with clang.

Now the strange thing is that this does not bite Clang compilation much
more. But the only test that fails is unittest_denc. So I guess that
most of the code is rather well behaved.

And I'm off on a search to find the culprit.

--WjW



