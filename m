From: Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: CEPH on RHEL 7.1
Date: Wed, 10 Jun 2015 10:09:45 -0400 (EDT)
Message-ID: <1416078379.12904264.1433945385280.JavaMail.zimbra@redhat.com>
References: <C226B0AB34511445928D9882AA519F601C42B5E1@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <C226B0AB34511445928D9882AA519F601C42B5E1-cXZ6iGhjG0hm/BozF5lIdDJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Varada Kari <Varada.Kari-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

----- Original Message -----
> From: "Varada Kari" <Varada.Kari-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
> To: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Cc: "ceph-users" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
> Sent: Wednesday, June 10, 2015 3:33:08 AM
> Subject: [ceph-users] CEPH on RHEL 7.1
> 
> Hi,
> 
> We are trying to build CEPH on RHEL7.1. But facing some issues with the build
> with "Giant" branch.
> Enabled the redhat server rpms and redhat ceph storage rpm channels along
> with optional, extras and supplementary. But we are not able to find
> gperftools, leveldb and yasm rpms in the channels.
> Did anyone try building ceph in RHEL 7.1? Do I need to add any channels to
> get these packages?

The leveldb-devel, gperftools-devel, and yasm packages in EPEL should allow you to build Ceph. The ceph.com builds use the EPEL packages as dependencies.

- Ken
