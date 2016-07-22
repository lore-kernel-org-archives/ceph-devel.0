From: "Yan, Zheng" <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: CephFS Samba VFS RHEL packages
Date: Fri, 22 Jul 2016 10:12:01 +0800
Message-ID: <CAAM7YAm_U0z9VQSnb=ERD1mgP=JNc+6zS6b8jPDOMhCaxP9AEw@mail.gmail.com>
References: <CA+z5Dsx7phEMT1oxENzCwXxQrB0NtCLwxWGPKF+NeMZNr+KkSw@mail.gmail.com>
	<CALqRxCwg3jFN2OTC2ut=otHukOGHw9p9r7+RbByvQdTMBifM8A@mail.gmail.com>
	<CA+z5DszcKbrEcAssNFQEfaE5ugwOaxs3RbcO1s+n9fkGK18K=A@mail.gmail.com>
	<20160722011122.GA26458@ira-t460p.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20160722011122.GA26458-cxR8Fnf47+XrpQ1Nw3gw2A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ira Cooper <ira-mA6sH8tAw6XR7s880joybQ@public.gmane.org>
Cc: John Spray <john.spray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Jul 22, 2016 at 9:11 AM, Ira Cooper <ira-mA6sH8tAw6XR7s880joybQ@public.gmane.org> wrote:
> On Fri, Jul 22, 2016 at 08:29:39AM +1100, Blair Bethwaite wrote:
>> Ken, Ira, John -
>>
>> Thanks a lot for the replies. Our initial setup is simply running
>> samba atop a cephfs kernel mount, and initial cursory checks seem to
>> show the basics are working as expected (even clustered with ctdb -
>> what are your concerns here Ira?). Though we've yet to try any of our
>> planned test scenarios/datasets.
>>
>> From the conversation here I'm thinking we'd be better off using
>> Xenial for our CephFS+Samba test nodes at the moment... though I only
>> see packages for Precise and Trusty on gitbuilder.ceph.com at the
>> moment. We were planning to compare samba on kernel mount versus ceph
>> vfs.
>>
>> Can someone clarify what state the cephfs kernel client in RHEL 7.x
>> will be in when RHCS 2.0 is released, i.e., will that be back-ported
>> or are RHEL users expected to use FUSE? (I'm happy to go ask support
>> directly but I suspect this is useful information for others too).

We actively back-port fixes to RHEL 7.x kernel.  When RHCS2.0 release,
the RHEL kernel should contain fixes up to 3.7 upstream kernel.

Regards
Yan, Zheng

>
> Please note: icooper-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org is not on this list, so I can't
> reply from there ;).
>
> I recommend you test your setup THROUGHLY.  CTDB is really in
> place to handle failures, so test node failures.  I recommend
> hard power-offs for this.  The real world is rarely as kind
> as a "nice" poweroff, and it might trick you into thinking
> more is working than is.
>
> If you get it right, all the nodes should end up banned if I
> remember right.  It's been a bit since I tested with stock
> settings.
>
> For my setup I use:
>
> FUSE for the mount so CTDB works.
> vfs_ceph for the Samba datapath.
>
> That's what I'd recommend based on talking to people.
>
> No idea on RHCS/Kernel.
>
> Cheers,
>
> -Ira
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
