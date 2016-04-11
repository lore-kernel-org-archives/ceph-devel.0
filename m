From: Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Deprecating ext4 support
Date: Mon, 11 Apr 2016 18:49:09 -0400 (EDT)
Message-ID: <910987783.8526680.1460414949416.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
	<alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com>
	<570C1DBC.3040408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <570C1DBC.3040408-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Just to clarify to prevent any confusion.

Honestly I've never used ext4 as underlying filesystem for the Ceph cluster, but according to wiki [1], ext4 is recommended -;

[1] https://en.wikipedia.org/wiki/Ceph_%28software%29

Shinobu

----- Original Message -----
From: "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
To: "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
Sent: Tuesday, April 12, 2016 6:57:16 AM
Subject: Re: [ceph-users] Deprecating ext4 support

On 04/11/2016 04:44 PM, Sage Weil wrote:
> On Mon, 11 Apr 2016, Sage Weil wrote:
>> Hi,
>>
>> ext4 has never been recommended, but we did test it.  After Jewel is out,
>> we would like explicitly recommend *against* ext4 and stop testing it.
>
> I should clarify that this is a proposal and solicitation of feedback--we
> haven't made any decisions yet.  Now is the time to weigh in.

To add to this on the performance side, we stopped doing regular 
performance testing on ext4 (and btrfs) sometime back around when ICE 
was released to focus specifically on filestore behavior on xfs.  There 
were some cases at the time where ext4 was faster than xfs, but not 
consistently so.  btrfs is often quite fast on fresh fs, but degrades 
quickly due to fragmentation induced by cow with 
small-writes-to-large-object workloads (IE RBD small writes).  If btrfs 
auto-defrag is now safe to use in production it might be worth looking 
at again, but probably not ext4.

Set sail for bluestore!

Mark

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
