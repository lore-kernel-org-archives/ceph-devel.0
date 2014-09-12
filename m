From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Regarding key/value interface
Date: Fri, 12 Sep 2014 05:48:05 +0000
Message-ID: <7334B4281E425749B85E08CF7EC6F8532AEACD54@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783D176@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1409111825480.513@cobra.newdream.net>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2783D2E3@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1409111851240.513@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0076.outbound.protection.outlook.com ([157.56.110.76]:52864
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751553AbaILGUh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Sep 2014 02:20:37 -0400
In-Reply-To: <alpine.DEB.2.00.1409111851240.513@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Haomai Wang (haomaiwang@gmail.com)" <haomaiwang@gmail.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Another thing we're looking into is compression. The intersection of compression and object striping (fracturing) is interesting. Is the striping variable on a per-object basis? 

Allen Samuels
Chief Software Architect, Emerging Storage Solutions 

951 SanDisk Drive, Milpitas, CA 95035
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Thursday, September 11, 2014 6:55 PM
To: Somnath Roy
Cc: Haomai Wang (haomaiwang@gmail.com); ceph-users@lists.ceph.com; ceph-devel@vger.kernel.org
Subject: RE: Regarding key/value interface

On Fri, 12 Sep 2014, Somnath Roy wrote:
> Make perfect sense Sage..
> 
> Regarding striping of filedata, You are saying KeyValue interface will do the following for me?
> 
> 1. Say in case of rbd image of order 4 MB, a write request coming to Key/Value interface, it will  chunk the object (say full 4MB) in smaller sizes (configurable ?) and stripe it as multiple key/value pair ?
> 
> 2. Also, while reading it will take care of accumulating and send it back.

Precisely.

A smarter thing we might want to make it do in the future would be to take a 4 KB write create a new key that logically overwrites part of the larger, say, 1MB key, and apply it on read.  And maybe give up and rewrite the entire 1MB stripe after too many small overwrites have accumulated.  
Something along those lines to reduce the cost of small IOs to large objects.

sage



 > 
> Thanks & Regards
> Somnath
> 
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Thursday, September 11, 2014 6:31 PM
> To: Somnath Roy
> Cc: Haomai Wang (haomaiwang@gmail.com); ceph-users@lists.ceph.com; 
> ceph-devel@vger.kernel.org
> Subject: Re: Regarding key/value interface
> 
> Hi Somnath,
> 
> On Fri, 12 Sep 2014, Somnath Roy wrote:
> >
> > Hi Sage/Haomai,
> >
> > If I have a key/value backend that support transaction, range 
> > queries (and I don?t need any explicit caching etc.) and I want to 
> > replace filestore (and leveldb omap) with that,  which interface you 
> > recommend me to derive from , directly ObjectStore or  KeyValueDB ?
> >
> > I have already integrated this backend by deriving from ObjectStore 
> > interfaces earlier (pre keyvalueinteface days) but not tested 
> > thoroughly enough to see what functionality is broken (Basic 
> > functionalities of RGW/RBD are working fine).
> >
> > Basically, I want to know what are the advantages (and 
> > disadvantages) of deriving it from the new key/value interfaces ?
> >
> > Also, what state is it in ? Is it feature complete and supporting 
> > all the ObjectStore interfaces like clone and all ?
> 
> Everything is supported, I think, for perhaps some IO hints that don't make sense in a k/v context.  The big things that you get by using KeyValueStore and plugging into the lower-level interface are:
> 
>  - striping of file data across keys
>  - efficient clone
>  - a zillion smaller methods that aren't conceptually difficult to implement bug tedious and to do so.
> 
> The other nice thing about reusing this code is that you can use a leveldb or rocksdb backend as a reference for testing or performance or whatever.
> 
> The main thing that will be a challenge going forward, I predict, is making storage of the object byte payload in key/value pairs efficient.  I think KeyValuestore is doing some simple striping, but it will suffer for small overwrites (like 512-byte or 4k writes from an RBD).  There are probably some pretty simple heuristics and tricks that can be done to mitigate the most common patterns, but there is no simple solution since the backends generally don't support partial value updates (I assume yours doesn't either?).  But, any work done here will benefit the other backends too so that would be a win..
> 
> sage
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
