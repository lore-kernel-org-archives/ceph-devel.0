From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph write path
Date: Thu, 24 Jan 2013 20:54:23 -0800
Message-ID: <E64A5CCB93314AE5B631811CE56F46CA@inktank.com>
References: <CAB7xdikxeLumDMJNYacoxiiijkx2vekAdc5ccDy0A+5isOJ-3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:39129 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab3AYE7g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 23:59:36 -0500
Received: by mail-qc0-f181.google.com with SMTP id x40so832761qcp.12
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 20:59:35 -0800 (PST)
In-Reply-To: <CAB7xdikxeLumDMJNYacoxiiijkx2vekAdc5ccDy0A+5isOJ-3Q@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thursday, January 24, 2013 at 6:41 PM, sheng qiu wrote:
> Hi,
> 
> i am trying to understand the ceph codes on client side.
> for write path, if it's aio_write, the ceph_write_begin() allocate
> pages in page cache to buffer the written data, however i did not see
> it allocated any space on the remote OSDs (for local fs such as ext2,
> the get_block() did this),
> i suppose it's done later when invoke kernel flushing process to write
> back the dirty pages.
> 
> i checked the ceph_writepages_start(), here it seems organize the
> dirty data and prepare the requests to send to the OSDs. For new
> allocated written data, how it maps to the OSDs and where it is done?
> is it done in ceph_osdc_new_request()?
> 
> If the transfer unit is not limited to sizes of obj, i supposed that
> ceph needed to packed several pieces of data (smaller than one obj
> size) together so that there won't be internal fragmentation for an
> object. who does this job and which part of source codes/files are
> related with this?
> 
> I really want to get a deep understanding about the codes, so i raised
> these questions. if my understanding is not correct, please figure
> out. i will be very appreciated.
> 
There seems to be a bit of a fundamental misunderstanding here. The Ceph storage system is built on top of an object store (RADOS), and so when the clients are doing writes they just tell the object storage daemon (OSD) to write the named object. The daemons are responsible for doing disk allocation and layout stuff themselves (and in fact they handle most of that by sticking the objects in a perfectly ordinary Linux filesystem).
The client maps the data to the correct OSDs via the CRUSH algorithm; it's a calculation based on the object name that anybody in the system can perform; there's no lookup or anything. 
It doesn't do any packing of different pieces of data into one object or anything like that.

I'd recommend checking out some of the academic papers available at http://ceph.com/resources/publications/ for more background information about the key algorithms and design choices.
-Greg

