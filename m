From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Regarding key/value interface
Date: Fri, 12 Sep 2014 01:46:25 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783D2E3@SACMBXIP02.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783D176@SACMBXIP02.sdcorp.global.sandisk.com>
	<alpine.DEB.2.00.1409111825480.513@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1409111825480.513-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Make perfect sense Sage..

Regarding striping of filedata, You are saying KeyValue interface will do the following for me?

1. Say in case of rbd image of order 4 MB, a write request coming to Key/Value interface, it will  chunk the object (say full 4MB) in smaller sizes (configurable ?) and stripe it as multiple key/value pair ?

2. Also, while reading it will take care of accumulating and send it back.


Thanks & Regards
Somnath


-----Original Message-----
From: Sage Weil [mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
Sent: Thursday, September 11, 2014 6:31 PM
To: Somnath Roy
Cc: Haomai Wang (haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org); ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: Regarding key/value interface

Hi Somnath,

On Fri, 12 Sep 2014, Somnath Roy wrote:
>
> Hi Sage/Haomai,
>
> If I have a key/value backend that support transaction, range queries
> (and I don?t need any explicit caching etc.) and I want to replace
> filestore (and leveldb omap) with that,  which interface you recommend
> me to derive from , directly ObjectStore or  KeyValueDB ?
>
> I have already integrated this backend by deriving from ObjectStore
> interfaces earlier (pre keyvalueinteface days) but not tested
> thoroughly enough to see what functionality is broken (Basic
> functionalities of RGW/RBD are working fine).
>
> Basically, I want to know what are the advantages (and disadvantages)
> of deriving it from the new key/value interfaces ?
>
> Also, what state is it in ? Is it feature complete and supporting all
> the ObjectStore interfaces like clone and all ?

Everything is supported, I think, for perhaps some IO hints that don't make sense in a k/v context.  The big things that you get by using KeyValueStore and plugging into the lower-level interface are:

 - striping of file data across keys
 - efficient clone
 - a zillion smaller methods that aren't conceptually difficult to implement bug tedious and to do so.

The other nice thing about reusing this code is that you can use a leveldb or rocksdb backend as a reference for testing or performance or whatever.

The main thing that will be a challenge going forward, I predict, is making storage of the object byte payload in key/value pairs efficient.  I think KeyValuestore is doing some simple striping, but it will suffer for small overwrites (like 512-byte or 4k writes from an RBD).  There are probably some pretty simple heuristics and tricks that can be done to mitigate the most common patterns, but there is no simple solution since the backends generally don't support partial value updates (I assume yours doesn't either?).  But, any work done here will benefit the other backends too so that would be a win..

sage

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
