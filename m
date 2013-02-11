From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH 01/15] kv_flat_btree_async.cc: use vector instead of VLA's
Date: Mon, 11 Feb 2013 14:21:33 +0100
Message-ID: <5118F05D.8020304@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de> <1360266123-28972-2-git-send-email-danny.al-gaaf@bisect.de> <alpine.DEB.2.00.1302092155330.11665@cobra.newdream.net>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:49110 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757157Ab3BKNVj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Feb 2013 08:21:39 -0500
In-Reply-To: <alpine.DEB.2.00.1302092155330.11665@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am 10.02.2013 06:57, schrieb Sage Weil:
> On Thu, 7 Feb 2013, Danny Al-Gaaf wrote:
>> Fix "variable length array of non-POD element type" errors caused by
>> using librados::ObjectWriteOperation VLAs. (-Wvla)
>>
>> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
>> ---
>>  src/key_value_store/kv_flat_btree_async.cc | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/src/key_value_store/kv_flat_btree_async.cc b/src/key_value_store/kv_flat_btree_async.cc
>> index 96c6cb0..4342e70 100644
>> --- a/src/key_value_store/kv_flat_btree_async.cc
>> +++ b/src/key_value_store/kv_flat_btree_async.cc
>> @@ -1119,9 +1119,9 @@ int KvFlatBtreeAsync::cleanup(const index_data &idata, const int &errno) {
>>      //all changes were created except for updating the index and possibly
>>      //deleting the objects. roll forward.
>>      vector<pair<pair<int, string>, librados::ObjectWriteOperation*> > ops;
>> -    librados::ObjectWriteOperation owos[idata.to_delete.size() + 1];
>> +    vector<librados::ObjectWriteOperation*> owos(idata.to_delete.size() + 1);
> 
> I haven't read much of the surrounding code, but from what is included 
> here I don't think this is equivalent... these are just null pointers 
> initially, and so
> 
>>      for (int i = 0; i <= (int)idata.to_delete.size(); ++i) {
>> -      ops.push_back(make_pair(pair<int, string>(0, ""), &owos[i]));
>> +      ops.push_back(make_pair(pair<int, string>(0, ""), owos[i]));
> 
> this doesn't do anything useful... owos[i] may as well be NULL.  Why not 
> make it
> 
> vector<librados::ObjectWriteOperation> owos(...)
> 
> ?

Because this would lead to a linker error:

kv_flat_btree_async.o: In function `void
std::__uninitialized_fill_n<false>::__uninit_fill_n<librados::ObjectWriteOperation*,
unsigned long,
librados::ObjectWriteOperation>(librados::ObjectWriteOperation*,
unsigned long, librados::ObjectWriteOperation const&)':
/usr/bin/../lib64/gcc/x86_64-suse-linux/4.7/../../../../include/c++/4.7/bits/stl_uninitialized.h:188:
undefined reference to
`librados::ObjectOperation::ObjectOperation(librados::ObjectOperation
const&)'
/usr/bin/../lib64/gcc/x86_64-suse-linux/4.7/../../../../include/c++/4.7/bits/stl_uninitialized.h:188:
undefined reference to
`librados::ObjectOperation::ObjectOperation(librados::ObjectOperation
const&)'


Because in src/include/rados/librados.hpp
librados::ObjectOperation::ObjectOperation(librados::ObjectOperation
const&) was is defined, but not implemented in the librados.cc.

Not sure if removing ObjectOperation(librados::ObjectOperation const&)
is the way to go here.

Danny
