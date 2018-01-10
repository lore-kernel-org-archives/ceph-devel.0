From: kefu chai <tchaikov@gmail.com>
Subject: Re: Build failed in Jenkins: ceph-master #1640
Date: Wed, 10 Jan 2018 20:57:20 +0800
Message-ID: <CAJE9aON7tu3-eTrfyfHK0ZJRatLEoU7uZ6dkjsBiM0KFn8V3gg@mail.gmail.com>
References: <561378466.11.1515481542226.JavaMail.jenkins@cephdev.digiware.nl> <82eb2a12-9b0c-855c-6a53-fbf1b8d55bc8@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:42488 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933931AbeAJM5V (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jan 2018 07:57:21 -0500
Received: by mail-qk0-f173.google.com with SMTP id q1so5683084qkb.9
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jan 2018 04:57:21 -0800 (PST)
In-Reply-To: <82eb2a12-9b0c-855c-6a53-fbf1b8d55bc8@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jan 9, 2018 at 4:34 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Kefu,
>
> I guess my Clang/FreeBSD does not like your changes to the dencode stuff.

it took me a while to setup the clang building env. and ... Adam has
fixed it at https://github.com/ceph/ceph/pull/19877 !

>
> --WjW
>
>
> -------- Forwarded Message --------
> Subject: Build failed in Jenkins: ceph-master #1640
> Date: Tue, 9 Jan 2018 08:05:41 +0100 (CET)
> From: jenkins@digiware.nl
> Reply-To: jenkins@digiware.nl
> To: wjw@digiware.nl
>
> See
> <http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/1640/display/redirect?page=changes>
>
> Changes:
>
> [jcollin] doc: fix heading
>
> [kchai] denc: use constexpr-if to replace some SFINAE impls
>
> [jcollin] doc: misc fixes
>
> ------------------------------------------
> [...truncated 563.83 KB...]
>   traits::bound_encode(o, len);
>   ^~~~~~~~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/include/CompatSet.h:77:9: note: in
> instantiation of function template specialization
> 'encode<std::__1::map<unsigned long, std::__1::basic_string<char>,
> std::__1::less<unsigned long>, std::__1::allocator<std::__1::pair<const
> unsigned long, std::__1::basic_string<char> > > >,
> denc_traits<std::__1::map<unsigned long, std::__1::basic_string<char>,
> std::__1::less<unsigned long>, std::__1::allocator<std::__1::pair<const
> unsigned long, std::__1::basic_string<char> > > >, void> >' requested here
>       ::encode(names, bl);
>         ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:863:5: note:
> candidate template ignored: substitution failure [with U =
> std::__1::pair<unsigned long, std::__1::basic_string<char> >]: non-type
> template argument evaluates to 32, which cannot be narrowed to type 'bool'
>     bound_encode(const container& s, size_t& p, uint64_t f = 0) {
>     ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1530:3: error: no
> matching function for call to 'encode'
>   traits::encode(o, a);
>   ^~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/include/denc.h:890:5: note:
> candidate template ignored: substitution failure [with U =
> std::__1::pair<unsigned long, std::__1::basic_string<char> >]: non-type
> template argument evaluates to 32, which cannot be narrowed to type 'bool'
>     encode(const container& s, buffer::list::contiguous_appender& p,
>     ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1528:3: error: no
> matching function for call to 'bound_encode'
>   traits::bound_encode(o, len);
>   ^~~~~~~~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/common/snap_types.h:58:7: note: in
> instantiation of function template specialization
> 'encode<std::__1::vector<snapid_t, std::__1::allocator<snapid_t> >,
> denc_traits<std::__1::vector<snapid_t, std::__1::allocator<snapid_t> >,
> void> >' requested here
>     ::encode(snaps, bl);
>       ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:863:5: note:
> candidate template ignored: substitution failure [with U = snapid_t]:
> non-type template argument evaluates to 8, which cannot be narrowed to type
> 'bool'
>     bound_encode(const container& s, size_t& p, uint64_t f = 0) {
>     ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1530:3: error: no
> matching function for call to 'encode'
>   traits::encode(o, a);
>   ^~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/include/denc.h:890:5: note:
> candidate template ignored: substitution failure [with U = snapid_t]:
> non-type template argument evaluates to 8, which cannot be narrowed to type
> 'bool'
>     encode(const container& s, buffer::list::contiguous_appender& p,
>     ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1528:3: error: no
> matching function for call to 'bound_encode'
>   traits::bound_encode(o, len);
>   ^~~~~~~~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/osd/osd_types.h:3199:7: note: in
> instantiation of function template specialization
> 'encode<std::__1::map<std::__1::basic_string<char>,
> boost::optional<ceph::buffer::list>,
> std::__1::less<std::__1::basic_string<char> >,
> std::__1::allocator<std::__1::pair<const std::__1::basic_string<char>,
> boost::optional<ceph::buffer::list> > > >,
> denc_traits<std::__1::map<std::__1::basic_string<char>,
> boost::optional<ceph::buffer::list>,
> std::__1::less<std::__1::basic_string<char> >,
> std::__1::allocator<std::__1::pair<const std::__1::basic_string<char>,
> boost::optional<ceph::buffer::list> > > >, void> >' requested here
>     ::encode(old_attrs, bl);
>       ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:863:5: note:
> candidate template ignored: substitution failure [with U =
> std::__1::pair<std::__1::basic_string<char>,
> boost::optional<ceph::buffer::list> >]: non-type template argument evaluates
> to 120, which cannot be narrowed to type 'bool'
>     bound_encode(const container& s, size_t& p, uint64_t f = 0) {
>     ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1530:3: error: no
> matching function for call to 'encode'
>   traits::encode(o, a);
>   ^~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/include/denc.h:890:5: note:
> candidate template ignored: substitution failure [with U =
> std::__1::pair<std::__1::basic_string<char>,
> boost::optional<ceph::buffer::list> >]: non-type template argument evaluates
> to 120, which cannot be narrowed to type 'bool'
>     encode(const container& s, buffer::list::contiguous_appender& p,
>     ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1528:3: error: no
> matching function for call to 'bound_encode'
>   traits::bound_encode(o, len);
>   ^~~~~~~~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/osd/osd_types.h:3235:7: note: in
> instantiation of function template specialization
> 'encode<std::__1::set<snapid_t, std::__1::less<snapid_t>,
> std::__1::allocator<snapid_t> >, denc_traits<std::__1::set<snapid_t,
> std::__1::less<snapid_t>, std::__1::allocator<snapid_t> >, void> >'
> requested here
>     ::encode(old_snaps, bl);
>       ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:863:5: note:
> candidate template ignored: substitution failure [with U = snapid_t]:
> non-type template argument evaluates to 8, which cannot be narrowed to type
> 'bool'
>     bound_encode(const container& s, size_t& p, uint64_t f = 0) {
>     ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1530:3: error: no
> matching function for call to 'encode'
>   traits::encode(o, a);
>   ^~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/include/denc.h:890:5: note:
> candidate template ignored: substitution failure [with U = snapid_t]:
> non-type template argument evaluates to 8, which cannot be narrowed to type
> 'bool'
>     encode(const container& s, buffer::list::contiguous_appender& p,
>     ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1528:3: error: no
> matching function for call to 'bound_encode'
>   traits::bound_encode(o, len);
>   ^~~~~~~~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/osd/osd_types.h:3247:7: note: in
> instantiation of function template specialization
> 'encode<std::__1::vector<std::__1::pair<unsigned long, unsigned long>,
> std::__1::allocator<std::__1::pair<unsigned long, unsigned long> > >,
> denc_traits<std::__1::vector<std::__1::pair<unsigned long, unsigned long>,
> std::__1::allocator<std::__1::pair<unsigned long, unsigned long> > >, void>
>>' requested here
>     ::encode(extents, bl);
>       ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:863:5: note:
> candidate template ignored: substitution failure [with U =
> std::__1::pair<unsigned long, unsigned long>]: non-type template argument
> evaluates to 16, which cannot be narrowed to type 'bool'
>     bound_encode(const container& s, size_t& p, uint64_t f = 0) {
>     ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1530:3: error: no
> matching function for call to 'encode'
>   traits::encode(o, a);
>   ^~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/include/denc.h:890:5: note:
> candidate template ignored: substitution failure [with U =
> std::__1::pair<unsigned long, unsigned long>]: non-type template argument
> evaluates to 16, which cannot be narrowed to type 'bool'
>     encode(const container& s, buffer::list::contiguous_appender& p,
>     ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1528:3: error: no
> matching function for call to 'bound_encode'
>   traits::bound_encode(o, len);
>   ^~~~~~~~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/osd/OSDMap.h:240:7: note: in
> instantiation of function template specialization
> 'encode<std::__1::vector<int,
> mempool::pool_allocator<mempool::pool_index_t::mempool_osdmap, int> >,
> denc_traits<std::__1::vector<int,
> mempool::pool_allocator<mempool::pool_index_t::mempool_osdmap, int> >, void>
>>' requested here
>     ::encode(v, data);
>       ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:863:5: note:
> candidate template ignored: substitution failure [with U = int]: non-type
> template argument evaluates to 4, which cannot be narrowed to type 'bool'
>     bound_encode(const container& s, size_t& p, uint64_t f = 0) {
>     ^
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1530:3: error: no
> matching function for call to 'encode'
>   traits::encode(o, a);
>   ^~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/include/denc.h:890:5: note:
> candidate template ignored: substitution failure [with U = int]: non-type
> template argument evaluates to 4, which cannot be narrowed to type 'bool'
>     encode(const container& s, buffer::list::contiguous_appender& p,
>     ^
> 18 errors generated.
> Build step 'Execute shell' marked build as failure
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
