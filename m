From: Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>
Subject: Re: Ceph v0.79 Firefly RC :: erasure-code-profile
 command set not present
Date: Tue, 08 Apr 2014 22:12:56 +1200
Message-ID: <5343CBA8.1050703@catalyst.net.nz>
References: <3423E02F-D2A2-4E7A-99BF-9B277FF3AB19@csc.fi>
	<5343C143.70803@catalyst.net.nz>
	<6CD10D8D-16D8-4BFE-B270-D14E11D9FCF7@csc.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <6CD10D8D-16D8-4BFE-B270-D14E11D9FCF7-Gn+qtVAUx6s@public.gmane.org>
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

I'm not sure if this is relevant, but my 0.78 (and currently building 
0.79) are compiled from src git checkout (and packages built from the 
same src tree using dpkg-buildpackage Debian/Ubuntu package builder).

Having said that - the above procedure *should* produce equivalent 
binaries to the official Debian/Ubuntu and Redhat/Centos packages 
(unless there is a specific bug in the rpm style builds).

Cheers

Mark

On 08/04/14 21:44, Karan Singh wrote:
> Thanks Mark for this quick checkup on Ubuntu distro. you saved my time ,
> i was also checking the same thing.
>
> All of my ceph components are on 0.79 , this looks to be a problem with
> ceph binaries for RHEL.
>
> @ Ceph Developers :  Any thought on this.
>
