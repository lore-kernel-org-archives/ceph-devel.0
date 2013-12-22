From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Refactor DBObjectMap Proposal
Date: Sun, 22 Dec 2013 17:44:12 +0800
Message-ID: <8EBF9EDC-BF8D-42D7-94D9-222DBDEB6AE4@gmail.com>
References: <CACJqLyaxvRF8R51i0atG_GgFvWcWDZMjrzbBwJG0SPiziSKp1g@mail.gmail.com> <alpine.DEB.2.00.1312112117020.4714@cobra.newdream.net> <CACJqLybbLiqv+Z5HZtwVAdYQLe-db2vsb=eO6oXT9qGZ6UNQnQ@mail.gmail.com> <alpine.DEB.2.00.1312120858020.26867@cobra.newdream.net> <40FB64F4-9A8A-4E2B-86F7-CC61EDFEEE0F@gmail.com> <alpine.DEB.2.00.1312212119140.2168@cobra.newdream.net> <6F5C0608-09BB-4370-9599-FC3BCFDE46B5@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:34354 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab3LVJoV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Dec 2013 04:44:21 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so4270720pbb.17
        for <ceph-devel@vger.kernel.org>; Sun, 22 Dec 2013 01:44:20 -0800 (PST)
In-Reply-To: <6F5C0608-09BB-4370-9599-FC3BCFDE46B5@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org


On Dec 22, 2013, at 2:02 PM, Haomai Wang <haomaiwang@gmail.com> wrote:

> 
> On Dec 22, 2013, at 1:20 PM, Sage Weil <sage@inktank.com> wrote:
> 
>> On Sat, 21 Dec 2013, Haomai Wang wrote:
>>> On Dec 13, 2013, at 1:01 AM, Sage Weil <sage@inktank.com> wrote:
>>> 
>>>> On Thu, 12 Dec 2013, Haomai Wang wrote:
>>>>> On Thu, Dec 12, 2013 at 1:26 PM, Sage Weil <sage@inktank.com> wrote:
>>>>>> [adding cc ceph-devel]
>>>> 
>>>> [attempt 2]
>>>> 
>>>>>> 
>>>>>> On Wed, 11 Dec 2013, Haomai Wang wrote:
>>>>>>> Hi Sage,
>>>>>>> 
>>>>>>> Since last CDS, you have pointed jobs see below:
>>>>>>> 
>>>>>>> ============================
>>>>>>> 2. DBObjectMap: refactor interface
>>>>>>>  1. expose underlying KeyValueDB transactions to caller, so they
>>>>>>> can bundle several DBObjectMap ops together and capture an entire
>>>>>>> ObjectStore::Transaction's worth of work)
>>>>>>>  2.expose the user prefixes in a generic way, instead of
>>>>>>> hard-coding in the omap, xattr, and various internal namespaces
>>>>>>> 
>>>>>>> 3. stripe file data over keys
>>>>>>>  1. Build a class that will implement a file data interface (read
>>>>>>> extent, write extent, truncate, zero, etc.) on top of DBObjectMap
>>>>>>>  2. stripe data over keys of size X (e.g., 1MB, which seems to be
>>>>>>> the limit people are converging around)
>>>>>>>  3. store file size information in a metadata key.  maybe this can
>>>>>>> be DBObjectMap::Header; maybe not
>>>>>>>  4. contemplate future optimizations that put small objects
>>>>>>> "inline" in the Header (or equivalent) key
>>>>>>> ============================
>>>>>>> 
>>>>>>> I'm interested to implement it and I don't know whether you or others
>>>>>>> started to do it. Now I want to describe my idea.
>>>>>> 
>>>>>> Nobody is working on this just yet, although there is a lot of interest in
>>>>>> this area so your timing is very good!
>>>>>> 
>>>>>>> According to your comments, I think about implementing strip file data
>>>>>>> over keys in KeyValueStore class. Add a field called "userdata" to
>>>>>>> DBObjectMap::Header which is explained by caller such as
>>>>>>> KeyValueStore. Of course, we need to add CRUD operation interfaces for
>>>>>>> "userdata" field. So KeyValueStore will make use of "userdata" to
>>>>>>> manage stripped layer. Maybe a metadata table to map offset->key_name.
>>>>>> 
>>>>>> Yes.  My original thought is to make the DBObjectMap type fields a bit
>>>>>> more general (instead of the hard-coded #defines), but I don't think it
>>>>>> matters too much.
>>>>>> 
>>>>>> For the metadata table, yes eventually.. but I would keep it simple for
>>>>>> the first pass and iterate from there.
>>>>>> 
>>>>>>> Although DBObjectMap already implement clone operation on
>>>>>>> "USER_PREFIX" keys, I really don't like operations like lookup_parent
>>>>>>> which will cause dependent lookup chain resulting to performance
>>>>>>> degrade just like librbd. And I suspect that if using the current
>>>>>>> DBObjectMap methods to manage cloned objects, it may occur performance
>>>>>>> problems.  So DBObjectMap need to expose pure KeyValueDB interfaces
>>>>>>> called by KeyValueStore to store stripped keys which is controlled by
>>>>>>> a metadata table mentioned above. Others such as xattr and omap
>>>>>>> namespace won't be destroyed. Clone operation will be implemented via
>>>>>>> DBObjectMap::clone, actual object data won't be changed and only
>>>>>>> metadata table referenced to "userdata" will be copied. Any write
>>>>>>> operation will be redirected to new key. In other word, it may looks
>>>>>>> like librbd did, but here we implement it in ROW not COW.
>>>>>>> 
>>>>>>> The reason to design like above contains:
>>>>>>> 1. Export more works to KeyValueStore not DBObjectMap, DBObjectMap is
>>>>>>> used by FileStore which will limit big changes
>>>>>> 
>>>>>> Yes; we need to be a bit careful here.  I'm hoping the main changes though
>>>>>> are really just moving the transaction create and submit boilerplate in
>>>>>> each method into the FileStore callers?
>>>>> 
>>>>> In my mind, I don't want to change the caller codes such as FileStore.
>>>>> It works well now. ;-)
>>>> 
>>>> True.  We can also just make a second layer of methods (_foo() instead of 
>>>> foo() or someting) that take the transaction as an argument.
>>>> 
>>>> Or just fork DBObjectMap entirely so that we don't need to worry about 
>>>> breaking FileStore ondisk compatibility; we will likely want/need to do 
>>>> something like that eventually anyway!
>>> 
>>> I'm confusing by "_remove" interface in FileStore that doesn't remove omap
>>> keys with corresponding object. And I try to dump transaction what
>>> "rados rm object -p data" doing, actually no delete operations with omap keys.
>>> 
>>> So I'm wonder that it's the proper we don't remove omap keys? And I notice
>>> MemStore did omap erase operation:
>>> c->object_map.erase(oid);
>>> c->object_hash.erase(oid);
>> 
>> FileStore::_remove() calls lfn_unlink(), which calls 
>> object_map->clear(...) (if nlink == 0).
>> 
>> I think that's what you're looking for?
> 
> OH, it seemed that I missing it previously. Thank you.
> 
>> 
>> sage
>> 
>> 
>>> 
>>>> 
>>>> sage
>>>> 
>>>>>> 
>>>>>>> 2. Read/Write object is a more frequenter operation which different
>>>>>>> from OMap or xattr operations, we need more special handler now or
>>>>>>> future to optimize.
>>>>>>> 3. Different kv backend may have different features just like
>>>>>>> FileSystemBackend, we would like to deal with these at KeyValueStore
>>>>>>> not DBObjectMap or upper class.
>>>>>>> 4. DBObjectMap is a little replicated and maybe not suitable to do more things.
>>>>>> 
>>>>>> I'm not fully following this description, but it sounds like you're
>>>>>> thinking about the right issues.  A few comments:
>>>>>> 
>>>>>> - In the ideal case, we'd like to minimize the number of lookups/keys we
>>>>>> query to access an object.  This is a bit less important for objects that
>>>>>> are cloned (they tend to be snapshots... mostly).
>>>>>> 
>>>>>> - I think it makes sense to make the main header key for an object be able
>>>>>> to embed various bits of useful data, like
>>>>>> 
>>>>>> - all of the xattrs, if there aren't many of them
>>>>>> - the file size
>>>>>> - the file content, if it is small
>>>>>> 
>>>>>> No need for this in the initial implementation, but we should design
>>>>>> something that can accomodate it.
>>>>>> 
>>>>>> - It would be nice to capture the striping CRUD stuff in a separate class;
>>>>>> a child of DBObjectMap or something similar.  This will make it easy to
>>>>>> swap out and/or experiment with different approaches.
>>>>>> 
>>>>>>> So in this proposal, DBObjectMap will serve as a bridge in the front
>>>>>>> of KeyValueDB. KeyValueStore mainly use DBObjectMap API to store
>>>>>>> stripped object and DBObjectMap::Header to store metadata. If so, my
>>>>>>> previous implementation could be fully make use of. :-)
>>>>>> 
>>>>>> That's great news!  Let me know if there is anything we can do to help
>>>>>> here.

Another problem: Because DBObjectMap API only accept ghobject_t and have no info
about the object which collection belong to. So if using DBObjectMap inherent API,
it can't handle with ObjectStore APIs such as "collection_list" and "collection_empty".

If adding "coll_t" argument to DBObjectMap API and new obj_name->key function
"DBObjectMap::ghobject_key_v1", it looks like most of API needed to be rewrite
that I don't want. 

Another way is that adding a collection-objects mapping, which may add the number of
operations each transactions.

>>>>>> 
>>>>>> sage
>>>>> 
>>>>> Thanks for your comments!
>>>>> 
>>>>> 
>>>>> -- 
>>>>> Best Regards,
>>>>> 
>>>>> Wheat
>>> 
>>> Best regards,
>>> Wheats
> 
> Best regards,
> Wheats

Best regards,
Wheats



