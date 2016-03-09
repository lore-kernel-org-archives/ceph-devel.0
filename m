From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Getting a segmentation fault in running OSD
Date: Wed, 9 Mar 2016 12:43:22 +0100
Message-ID: <56E00C5A.8080004@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:36065 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbcCILnu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Mar 2016 06:43:50 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 5240F153A53
	for <ceph-devel@vger.kernel.org>; Wed,  9 Mar 2016 12:43:46 +0100 (CET)
Received: from [IPv6:2001:4cb8:3:1:b1f4:ee6a:bb8b:b213] (unknown [IPv6:2001:4cb8:3:1:b1f4:ee6a:bb8b:b213])
	by smtp.digiware.nl (Postfix) with ESMTP id 75AFD153A8B
	for <ceph-devel@vger.kernel.org>; Wed,  9 Mar 2016 12:43:26 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hoi,

FreeBSD has moved to a new release of Clang (3.8.0) so I do not exclude 
errors there.
But I thought I'd first ask here:

Would it be possible that this fragment of code from FileStore.cc

int FileStore::omap_get(const coll_t& _c, const ghobject_t &hoid,
                         bufferlist *header,
                         map<string, bufferlist> *out)
{
   tracepoint(objectstore, omap_get_enter, _c.c_str());
   const coll_t& c = !_need_temp_object_collection(_c, hoid) ? _c : 
_c.get_temp();
   dout(15) << __func__ << " " << c << "/" << hoid << dendl;

Calls ostream with a null pointer?
So either coll_t& c        is 0x0
Or const ghobject_t &hoid  is 0x0 (which it is not in higher frames..)

gdb frames around this are like:
#9  0x0000000000e0bbec in std::__1::operator<< 
<std::__1::char_traits<char> > (__os=..., __str=0x0) at 
/usr/include/c++/v1/ostream:894
894         return _VSTD::__put_character_sequence(__os, __str, 
_Traits::length(__str));
(gdb) fr 10
#10 0x00000000016d4dba in FileStore::omap_get_values(coll_t const&, 
ghobject_t const&, std::__1::set<std::__1::basic_string<char, 
std::__1::char_traits<char>, std::__1::allocator<char> >, 
std::__1::less<std::__1::basic_string<char, std::__1::char_traits<char>, 
std::__1::allocator<char> > >, 
std::__1::allocator<std::__1::basic_string<char, 
std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, 
std::__1::map<std::__1::basic_string<char, std::__1::char_traits<char>, 
std::__1::allocator<char> >, ceph::buffer::list, 
std::__1::less<std::__1::basic_string<char, std::__1::char_traits<char>, 
std::__1::allocator<char> > >, 
std::__1::allocator<std::__1::pair<std::__1::basic_string<char, 
std::__1::char_traits<char>, std::__1::allocator<char> > const, 
ceph::buffer::list> > >*) ()
(gdb) fr 11
#11 0x0000000001087b59 in OSDriver::get_keys (this=0x80cdfc018, 
keys=..., out=0x7fffd9fc95c8) at osd/SnapMapper.cc:30
30        return os->omap_get_values(cid, hoid, keys, out);

So there is definitely a null pointer going into operator<<

But it seems that most of omap_get_values is inlined, sinec I cannot get 
it to list or print any of the variables.

--WjW
