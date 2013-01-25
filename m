From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: ceph write path
Date: Fri, 25 Jan 2013 10:20:59 -0600
Message-ID: <CAB7xdin1y1WVEtvSRHWLv6iOaid-c4sUOaAWdgVZozY2UUHJtA@mail.gmail.com>
References: <CAB7xdikxeLumDMJNYacoxiiijkx2vekAdc5ccDy0A+5isOJ-3Q@mail.gmail.com>
	<alpine.DEB.2.00.1301242056150.14731@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:38691 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981Ab3AYQVB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 11:21:01 -0500
Received: by mail-oa0-f51.google.com with SMTP id n12so607540oag.24
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jan 2013 08:20:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301242056150.14731@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

i am appreciated for your reply.

by my understanding on reading the client codes, i think ceph
allocates msg based on individual file. In another word, if one client
is updating on different files (each file is doing small
writes/updates, i.e. 4kb), ceph has to compose different msgs for each
file and send them to the corresponding OSDs. if there are msgs
targeted on the same OSDs, can they be merged at client side? This may
help if the bandwidth of network is not sufficient, although i do not
know how much the chance they fall onto the same OSDs.
if my understanding is not correct, please figure out. i am doing
research on DFS, and pretty interested on ceph. Have you considered
manage a hybrid storage pool, while may compose of some faster devices
such as NVRAM/SSD and some slow devices such as HDD, and make ceph be
aware of this to better place/distribute data instead of a flat way.

Thanks,
Sheng


On Thu, Jan 24, 2013 at 11:00 PM, Sage Weil <sage@inktank.com> wrote:
> Hi Sheng,
>
> On Thu, 24 Jan 2013, sheng qiu wrote:
>> i am trying to understand the ceph codes on client side.
>> for write path, if it's aio_write, the ceph_write_begin() allocate
>> pages in page cache to buffer the written data, however i did not see
>> it allocated any space on the remote OSDs (for local fs such as ext2,
>> the get_block() did this),
>> i suppose it's done later when invoke kernel flushing process to write
>> back the dirty pages.
>
> Right.  Objects are instantiated and written to teh osds when the write
> operations are sent over the network, normally during writeback (via
> the ->writepages() op in addr.c).
>
>> i checked the ceph_writepages_start(), here it seems organize the
>> dirty data and prepare the requests to send to the OSDs.  For new
>> allocated written data, how it maps to the OSDs and where it is done?
>> is it done in ceph_osdc_new_request()?
>
> I happens later, when the actual request is ready to go over the wire. The
> target OSD may change in the meantime, or the request may have to be
> resent to another OSD.  As far as the upper layers are concerned, though,
> they are writing to the object, without caring where the object happens to
> currently live.
>
>> If the transfer unit is not limited to sizes of obj, i supposed that
>> ceph needed to packed several pieces of data (smaller than one obj
>> size)  together so that there won't be internal fragmentation for an
>> object. who does this job and which part of source codes/files are
>> related with this?
>
> Each file is striped over a different sequence of objects.  Small
> files mean small objects.  Large files stipe over (by default) 4
> MB objects.  It's the OSDs job to store these efficiently.  We just use a
> local file system.  btrfs is great about packing small files inline in the
> btree; xfs and ext4 are more convential fs's and pretty well.
>
> sage
>
>> I really want to get a deep understanding about the codes, so i raised
>> these questions. if my understanding is not correct, please figure
>> out. i will be very appreciated.
>>
>> Thanks,
>> Sheng
>>
>> --
>> Sheng Qiu
>> Texas A & M University
>> Room 332B Wisenbaker
>> email: herbert1984106@gmail.com
>> College Station, TX 77843-3259
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>



-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
