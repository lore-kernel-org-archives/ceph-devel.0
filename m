From: Dyweni - Ceph-Users <6EXbab4FYk8H-81vA1Z60lCrQT0dZR+AlfA@public.gmane.org>
Subject: Re: v10.0.2 released
Date: Thu, 14 Jan 2016 14:31:45 -0600
Message-ID: <dd25852a47b0ec0169e52a14f1a8ba45@pl1.haspere.com>
References: <alpine.DEB.2.11.1601141033010.21258@cpach.fuggernut.com>
	<CADRKj5TXdCmDS5aX5+HRee9fOr7Za4y_WGJhja0eyxhdTcHefA@mail.gmail.com>
	<CAEhqmjLGJN_c1wXW3yHc=kKab7w2mgfH6E8TqTds-VvKxDNfWA@mail.gmail.com>
Reply-To: 6EXbab4FYk8H-81vA1Z60lCrQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAEhqmjLGJN_c1wXW3yHc=kKab7w2mgfH6E8TqTds-VvKxDNfWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Bill Sanders <billysanders-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Does this support rbd images with stripe count > 1?

If yes, then this is also a solution for this problem:  
http://tracker.ceph.com/issues/3837


Thanks,
Dyweni




On 2016-01-14 13:27, Bill Sanders wrote:
> Is there some information about rbd-nbd somewhere?  If it has feature
> parity with librbd and is easier to maintain, will this eventually
> deprecate krbd?  We're using the RBD kernel client right now, and so
> this looks like something we might want to explore at my employer.
> 
> Bill
> 
> On Thu, Jan 14, 2016 at 9:04 AM, Yehuda Sadeh-Weinraub
> <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> On Thu, Jan 14, 2016 at 7:37 AM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> This development release includes a raft of changes and improvements 
>>> for
>>> Jewel. Key additions include CephFS scrub/repair improvements, an AIX 
>>> and
>>> Solaris port of librados, many librbd journaling additions and fixes,
>>> extended per-pool options, and NBD driver for RBD (rbd-nbd) that 
>>> allows
>>> librbd to present a kernel-level block device on Linux, multitenancy
>>> support for RGW, RGW bucket lifecycle support, RGW support for Swift
>> 
>> rgw bucket lifecycle isn't there, it still has some more way to go
>> before we merge it in.
>> 
>> Yehuda
>> 
>>> static large objects (SLO), and RGW support for Swift bulk delete.
>>> 
>>> There are also lots of smaller optimizations and performance fixes 
>>> going
>>> in all over the tree, particular in the OSD and common code.
>>> 
>>> Notable Changes
>>> ---------------
>>> 
>>> See
>>> 
>>>         http://ceph.com/releases/v10-0-2-released/
>>> 
>>> [I'd include the changelog here but I'm missing a oneliner that 
>>> renders
>>> the rst in email-suitable form...]
>>> 
>>> Getting Ceph
>>> ------------
>>> 
>>> * Git at git://github.com/ceph/ceph.git
>>> * Tarball at http://download.ceph.com/tarballs/ceph-10.0.2.tar.gz
>>> * For packages, see http://ceph.com/docs/master/install/get-packages
>>> * For ceph-deploy, see 
>>> http://ceph.com/docs/master/install/install-ceph-deploy
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
>>> in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
