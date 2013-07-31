From: Luke Jing Yuan <jyluke-YhiXQ1Q1pWA@public.gmane.org>
Subject: Re: Problem with MON after reboot
Date: Wed, 31 Jul 2013 10:32:03 +0000
Message-ID: <E0E280CCE0E1A44898C992A9190D929A4F9CB1@MBX02-TPM.mimos.local>
References: <E0E280CCE0E1A44898C992A9190D929A4F9C66@MBX02-TPM.mimos.local>
	<51F8E67A.90508@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <51F8E67A.90508-jJARgUQTjRwyzzc7d281tkhOQHIQSc2V@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: =?iso-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens-jJARgUQTjRwyzzc7d281tkhOQHIQSc2V@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

This happened to me twice actually. Once before I upgraded, using 0.61.4 (I=
 solved it by removing the MON and then recreating it) and this time after =
upgrading all nodes to 0.61.7. The surprising thing to me is that the node =
is also running OSD as well but after the upgrade and reboot, the cluster i=
s able to pick the OSD portion up but not the MON.

Regards,
Luke

-----Original Message-----
From: Jens Kristian S=F8gaard [mailto:jens-jJARgUQTjRwyzzc7d281tkhOQHIQSc2V@public.gmane.org] =

Sent: Wednesday, 31 July, 2013 6:27 PM
To: Luke Jing Yuan
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Subject: Re: [ceph-users] Problem with MON after reboot

Hi,

> I am having a issue with MON after reboot, I had originally 3 MONs but =

> after rebooting one of them, the quorum cannot be established. Digging

Did you happen to upgrade Ceph at some time where you haven't restarted the=
 daemon?

Which version of Ceph do you run on each server?

--
Jens Kristian S=F8gaard, Mermaid Consulting ApS, jens-jJARgUQTjRwyzzc7d281tkhOQHIQSc2V@public.gmane.org,=
 http://www.mermaidconsulting.com/
