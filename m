From: Bernard Grymonpon <bernard@openminds.be>
Subject: Re: defaults paths #2
Date: Fri, 6 Apr 2012 21:23:51 +0200
Message-ID: <F25C3F64-7052-4C1C-AF58-ED689234ECE1@openminds.be>
References: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com> <Pine.LNX.4.64.1204052204290.21401@cobra.newdream.net> <CAORUGqBq93+nWutxEAb=uWmEqCpCPCjcRKrzkTY4rRPMhfX1Vw@mail.gmail.com> <Pine.LNX.4.64.1204061038430.3020@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from november.openminds.be ([195.47.215.47]:59772 "EHLO
	november.openminds.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757760Ab2DFTXy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 15:23:54 -0400
In-Reply-To: <Pine.LNX.4.64.1204061038430.3020@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>


On 06 Apr 2012, at 19:55, Sage Weil wrote:

> On Fri, 6 Apr 2012, Tommi Virtanen wrote:
>> On Thu, Apr 5, 2012 at 22:12, Sage Weil <sage@newdream.net> wrote:
>>> Here's what I'm thinking:
>>> 
>>>  - No data paths are hard-coded except for /etc/ceph/*.conf
>>>  - We initially mount osd volumes in some temporary location (say,
>>>   /var/lib/ceph/temp/$uuid)
>>>  - We identify the oid, cluster uuid, etc., and determine where to mount
>>>   it with
>>> 
>>>        ceph-osd --cluster $cluster -i $id --show-config-value osd_data
>>> 
>>>   This will normally give you the default, unless the conf file specified
>>>   something else.
>>>  - Normal people get a default of /var/lib/ceph/$type/$id
>>>  - Multicluster crazies put
>>> 
>>>        [global]
>>>                osd data = /var/lib/ceph/$type/$cluster-$id
>>>                osd journal = /var/lib/ceph/$type/$cluster-$id/journal
>>>                mon data = /var/lib/ceph/$type/$cluster-$id
>>> 
>>>   (or whatever) in /etc/ceph/$cluster.conf and get something else.
>>> 
>>> Code paths are identical, data flow is identical.  We get a simple general
>>> case, without closing the door on multicluster configurations, which vary
>>> only by the config value that is easily adjusted on a per-cluster basis...
>> 
>> Except we lost features. Now I can't iterate the contents of a
>> directory and know what they mean. I think we'll need that.
> 
> Unless you infer it from the conf value or some such kludge, but that 
> would be fragile.  Okay.  I'm good with /var/lib/ceph/$type/$cluster-$id 
> then.
> 
> Hopefully we can keep things as general as possible, so that brave souls 
> can go out of bounds without getting bitten.  For example, never parse the 
> directory name if the same information can be had from the directory 
> contents.
> 
> Bernard, I suspect it would be pretty simple to make ceph-osd start up 
> either via -i <id> or --uuid <uuid> which would enable a uuid-based scheme 
> like you describe.  For these cookbooks, though, it'll be an <id>-based 
> approach.

Sure, I can live with that - I just give you my opinion. I'm happy that low-level tools and options will emerge to control very small parts and bits of ceph, which are needed to build solid and working deployment solutions.

If you provide "official" ceph cookbooks that don't work the way we like it, and manage things differently, then we'll build and maintain ours (like we already did), and take best of both to our opinion. It just bothers me that not only the storage-part is controlled and laid out (which is normal, ceph is about the storage), but now the way I manage my machines would be forced to be the ceph-way, and this is something I would not appreciate as a sysadmin.

But it seems as I misunderstood Tommi partially - none of the changes would go in the daemons, but are just scripts that will be provided to help - and I'm very much welcoming this. As long as ceph-osd is a simple storage daemon, and no fancy scan-it-all-and-start-as-you-feel daemon, I'm a happy person.

Rgds,
Bernard

> 
> sage

