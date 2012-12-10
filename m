From: Geoffrey Hartz <hartz.geoffrey@gmail.com>
Subject: Re: OSDs don't actually delete files when two CephFS (or more) are in use
Date: Mon, 10 Dec 2012 23:08:26 +0100
Message-ID: <CAPU8t+oZYJM8kt2th1RGqZKyOJ3xUSgz4i7HTQtdPBOvibb7Dg@mail.gmail.com>
References: <CAPU8t+pEuX2sP-gRqmCxGw-etrviOt1N7_18gv4=rDj+K6pkTA@mail.gmail.com>
	<50C644DD.8060707@inktank.com>
	<CAPU8t+oXgiAtHWjEXQ+8ODK1Hs=0Nep5V5rMm2k0DTsLSziq_g@mail.gmail.com>
	<50C6533C.50801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63086 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab2LJWI2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 17:08:28 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so1821286wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 14:08:27 -0800 (PST)
In-Reply-To: <50C6533C.50801@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: ceph-devel@vger.kernel.org

Ok!

I'm not in production yet. Only testing. In about 1/2months I will use
in real (waiting for v0.56 bobtail)

Thanks for your consideration! really appreciate.


I have an other strange behavior between CephFS and kernel mount

With ceph-fuse command :
Client 1 create 2000 files and do "ls" => 1/2sec
Client 2 do "ls" => 1/2sec

With mount -t ceph ...
Client 1 create 2000 files and do "ls" => few ms
Client 2 do "ls" => 4-5sec

2012/12/10 Sam Lang <sam.lang@inktank.com>:
> On 12/10/2012 10:34 AM, Geoffrey Hartz wrote:
>>
>> Hi.
>>
>> I wait about more than 15 minutes. I was doing some benchmark when I
>> noticed that the space never go back to normal..
>>
>> How can I disable this behavior? It's on Ceph side?
>>
>> With one client, OSD are cleaned after few seconds, this sounds normal
>
>
> Actually after discussing with Greg and Sage, it sounds like this is a bug.
> The issue is that the client that didn't remove the file is caching the
> dentry indefinitely.  I've created a ticket to track the issue here:
> http://tracker.newdream.net/issues/3601.
>
> Unfortunately, I don't think there's a good workaround for the time being.
> You can try to evict those cached dentries by creating/accessing a bunch of
> other files, but the default cache size on the client is 16384, which is a
> lot of files to touch just to free up the space for those removed files. :-)
>
> You can decrease the cache size with the config option client_cache_size:
>
> [client]
>         client cache size = 128
>
> Then you only have to create/touch 128 files to evict the other files from
> the cache.  That's not ideal, because reducing the cache size will affect
> your overall performance, but if you know that you won't be accessing a lot
> of files anyway, its probably your best bet.
>
> -sam
>
>
>>
>> 2012/12/10 Sam Lang <sam.lang@inktank.com>:
>>>
>>> On 12/10/2012 08:29 AM, Geoffrey Hartz wrote:
>>>>
>>>>
>>>> Hi!
>>>>
>>>> I'm new to Ceph and I have a strange behavior with CephFS
>>>>
>>>> Config is :
>>>>
>>>> Ubuntu 12.04
>>>> Kernel 3.6.9
>>>> Ceph V0.55
>>>>
>>>> 2 OSD, 1 mon, 1 MDS, all on same host
>>>> 2 clients, separate Hosts
>>>>
>>>> Ceph.conf:
>>>>
>>>> http://paste.ubuntu.com/1423712/
>>>>
>>>> To mount the share I use : sudo ceph-fuse -m 192.168.80.139:6789 /mnt
>>>>
>>>> When I create a file on one client, the other see the file, can be
>>>> downloaded etc.
>>>>
>>>> But when I delete the file, both clients don't see the file anymore
>>>> BUT the file is still there on OSD (using space disk).
>>>
>>>
>>>
>>> Removing a file removes the directory entry (as you've seen), but the
>>> inode
>>> itself doesn't get removed until all references to it are dropped.  The
>>> clients may cache the capability for those inodes for a period of time,
>>> so
>>> you're not seeing the references drop until they get evicted from the
>>> cache.
>>> Unmounting ensures that they get evicted from the client caches, so all
>>> references go to zero.
>>>
>>> Also, removal of the underlying objects is done lazily, so you may not
>>> see
>>> the space get freed up right away.
>>>
>>> -sam
>>>
>>>>
>>>> When I umount from BOTH clients, OSD are update and file is actually
>>>> delete (same behavior with mount -t ceph)
>>>>
>>>> I'm missing something?
>>>>
>>>> Thanks!
>>>>
>>>> --
>>>> Geoffrey HARTZ
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>
>>
>>
>



-- 
Geoffrey HARTZ
