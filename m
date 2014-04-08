From: Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>
Subject: Re: Ceph v0.79 Firefly RC :: erasure-code-profile
 command set not present
Date: Tue, 08 Apr 2014 21:28:35 +1200
Message-ID: <5343C143.70803@catalyst.net.nz>
References: <3423E02F-D2A2-4E7A-99BF-9B277FF3AB19@csc.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <3423E02F-D2A2-4E7A-99BF-9B277FF3AB19-Gn+qtVAUx6s@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Wow - that is a bit strange:

$ cat /etc/issue
Ubuntu 13.10 \n \l

$ sudo ceph -v
ceph version 0.78-569-g6a4c50d (6a4c50d7f27d2e7632d8c017d09e864e969a05f7)

$ sudo ceph osd erasure-code-profile ls
default
myprofile
profile
profile1

I'd hazard a guess that some of your ceph components are at version < =

0.78 still (partial upgrade or similar).

Regards

Mark

On 08/04/14 20:57, Karan Singh wrote:
> Thanks Developers for 0.79 , happy to see its announcement.
>
> I have been using 0.78 in order to test EC and TP , with 0.78 i was not
> able to test erasure code profile feature  ( # ceph osd
> erasure-code-profile set myprofile=85=85) as erasure-code-profile command
> set is not present in 0.78 but its mentioned in documentation.
>
> http://ceph.com/docs/master/dev/erasure-coded-pool/#interface
> https://ceph.com/docs/v0.78/dev/erasure-coded-pool/#interface
> https://ceph.com/docs/v0.79/dev/erasure-coded-pool/#interface
>
> I tried the same thing on 0.79 , but again looks like =93 ceph osd
> erasure-code-profile =93 command set is not implemented here as well.
>
> Do we need to wait for 0.80 release to test erasure-code-profile
>   feature ??
>
>
> # cat /etc/redhat-release
> CentOS release 6.4 (Final)
>
> # ceph -v
> ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)
>
> # ceph osd erasure-code-profile
> no valid command found; 10 closest matches:
> osd tier add-cache <poolname> <poolname> <int[0-]>
> osd tier set-overlay <poolname> <poolname>
> osd tier remove-overlay <poolname>
> osd tier remove <poolname> <poolname>
> osd tier cache-mode <poolname> none|writeback|forward|readonly
> osd thrash <int[0-]>
> osd tier add <poolname> <poolname> {--force-nonempty}
> osd stat
> osd reweight-by-utilization {<int[100-]>}
> osd pool stats {<name>}
> Error EINVAL: invalid command
> #
>
>
>
> ****************************************************************
> Karan Singh
> CSC - IT Center for Science,
> Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
> mobile: +358 503 812758
> tel. +358 9 4572001
> fax +358 9 4572302
> http://www.csc.fi/
> ****************************************************************
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
