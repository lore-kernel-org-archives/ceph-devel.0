From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: 70+  OSD are DOWN and not coming up
Date: Wed, 21 May 2014 21:15:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405212111030.12847@cobra.newdream.net>
References: <5396D45F-E87E-4F53-85D8-B4DC1F630B78@csc.fi>
	<alpine.DEB.2.00.1405200815570.1689@cobra.newdream.net>
	<537D541D.2010005@centraldesktop.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1327711602-1400732155=:12847"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <537D541D.2010005-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Craig Lewis <clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph Community <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1327711602-1400732155=:12847
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Wed, 21 May 2014, Craig Lewis wrote:
> If you do this over IRC, can you please post a summary to the mailling
> list?=A0
>=20
> I believe I'm having this issue as well.

In the other case, we found that some of the OSDs were behind processing=20
maps (by several thousand epochs).  The trick here to give them a chance=20
to catch up is

 ceph osd set noup
 ceph osd set nodown
 ceph osd set noout

and wait for them to stop spinning on the CPU.  You can check which map=20
each OSD is on with

 ceph daemon osd.NNN status

to see which epoch they are on and compare that to

 ceph osd stat

Once they are within 100 or less epochs,

 ceph osd unset noup

and let them all start up.

We haven't determined whether the original problem was caused by this or=20
the other way around; we'll see once they are all caught up.

sage
--557981400-1327711602-1400732155=:12847
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-1327711602-1400732155=:12847--
