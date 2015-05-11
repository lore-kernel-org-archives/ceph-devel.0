From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: EC backend benchmark
Date: Mon, 11 May 2015 21:28:43 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8A487@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8A41B@SACMBXIP01.sdcorp.global.sandisk.com>
	<55511E0A.7010408@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <55511E0A.7010408-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
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
To: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Loic,
I thought this one didn't go through !
I have sent another mail with attached doc.
This is the data with rados bench .
In case you missed it, could you please share your thoughts on the question=
s I posted (way below in the mail, not sure how so many space came along!!)=
 below ?

Thanks & Regards
Somnath

-----Original Message-----
From: Loic Dachary [mailto:loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org] =

Sent: Monday, May 11, 2015 2:24 PM
To: Somnath Roy
Cc: Ceph Development; ceph-users
Subject: Re: EC backend benchmark

Hi,

Thanks for sharing :-) Have you published the tools that you used to gather=
 these results ? It would be great to have a way to reproduce the same meas=
ures in different contexts.

Cheers

On 11/05/2015 23:13, Somnath Roy wrote:
>  =

> =

> Hi Loic and community,
> =

>  =

> =

> I have gathered the following data on EC backend (all flash). I have deci=
ded to use Jerasure since space saving is the utmost priority.
> =

>  =

> =

> Setup:
> =

> --------
> =

>  =

> =

> 41 OSDs (each on 8 TB flash), 5 node Ceph cluster. 48 core HT enabled cpu=
/64 GB RAM. Tested with Rados Bench clients.
> =

>  =

> =

>  =

> =

> EC plug-in
> =

> 	=

> =

> EC ratio
> =

> 	=

> =

> EC fault domain
> =

> 	=

> =

> Workload
> =

> 	=

> =

> Total clients
> =

> 	=

> =

> Num client Host
> =

> 	=

> =

> Runtime (Sec)
> =

> 	=

> =

> QD
> =

> (single client)
> =

> 	=

> =

> Latency/client
> =

> (avg/Max)
> =

> 	=

> =

> BW (aggregated)
> =

> 	=

> =

> Object_size
> =

> 	=

> =

> Node Cpu usage %
> =

> 	=

> =

> BW/HT core
> =

> Jerasure
> =

> 	=

> =

> 9,3
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.5/1.2
> =

> 	=

> =

> 1786 MB/S
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 28%
> =

> 	=

> =

> 132 MB/s
> =

> Jerasure
> =

> 	=

> =

> 9,3
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.9/2.1
> =

> 	=

> =

> 2174 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 35%
> =

> 	=

> =

> 129 MB/s
> =

> Jerasure
> =

> 	=

> =

> 4,1
> =

> 	=

> =

> Host
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.5/2.3
> =

> 	=

> =

> 1737 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 14%
> =

> 	=

> =

> 258 MB/s
> =

> Jerasure
> =

> 	=

> =

> 4,1
> =

> 	=

> =

> Host
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 1.0/25 (!)
> =

> 	=

> =

> 1783 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 14%
> =

> 	=

> =

> 265 MB/s
> =

> Jerasure
> =

> 	=

> =

> 15,3
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.6/1.4
> =

> 	=

> =

> 1530 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 40%
> =

> 	=

> =

> 79 MB/s
> =

> Jerasure
> =

> 	=

> =

> 15,3
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 1.0/4.7
> =

> 	=

> =

> 1886 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 45%
> =

> 	=

> =

> 87 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.5/1.2
> =

> 	=

> =

> 1917 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 24%
> =

> 	=

> =

> 166 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.8/2.2
> =

> 	=

> =

> 2281 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 28%
> =

> 	=

> =

> 170 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2 (RS_r6_op)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.5/1.2
> =

> 	=

> =

> 1876 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 25%
> =

> 	=

> =

> 156 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2 (RS_r6_op)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.8/1.9
> =

> 	=

> =

> 2292 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 31%
> =

> 	=

> =

> 154 MB/s
> =

> *Jerasure*
> =

> 	=

> =

> *6,2 (cauchy_orig)*
> =

> 	=

> =

> *OSD*
> =

> 	=

> =

> *PUT*
> =

> 	=

> =

> *4*
> =

> 	=

> =

> *1*
> =

> 	=

> =

> *100*
> =

> 	=

> =

> *64*
> =

> 	=

> =

> *0.5/1.1*
> =

> 	=

> =

> *2025 MB/s*
> =

> 	=

> =

> *4M*
> =

> 	=

> =

> *18%*
> =

> 	=

> =

> *234 MB/s*
> =

> *Jerasure*
> =

> 	=

> =

> *6,2 (cauchy_orig)*
> =

> 	=

> =

> *OSD*
> =

> 	=

> =

> *PUT*
> =

> 	=

> =

> *8*
> =

> 	=

> =

> *2*
> =

> 	=

> =

> *100*
> =

> 	=

> =

> *64*
> =

> 	=

> =

> *0.8/1.9*
> =

> 	=

> =

> *2497 MB/s*
> =

> 	=

> =

> *4M*
> =

> 	=

> =

> *21%*
> =

> 	=

> =

> *247 MB/s*
> =

> Jerasure
> =

> 	=

> =

> 6,2 (cauchy_good)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.5/1.3
> =

> 	=

> =

> 1947MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 18%
> =

> 	=

> =

> 225 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2 (cauchy_good)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.9/8.5
> =

> 	=

> =

> 2336 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 21%
> =

> 	=

> =

> 231 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2 (liberation)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.6/1.6
> =

> 	=

> =

> 1806 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 16%
> =

> 	=

> =

> 235 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2 (liberation)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 1.1/12
> =

> 	=

> =

> 1969 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 17%
> =

> 	=

> =

> 241 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2 (blaum_roth)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.5/1.5
> =

> 	=

> =

> 1859 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 17%
> =

> 	=

> =

> 227 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2 (blaum_roth)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 1.0/5.8
> =

> 	=

> =

> 2042 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 19%
> =

> 	=

> =

> 224 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2 (liber8tion)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.5/1.3
> =

> 	=

> =

> 1809 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 17%
> =

> 	=

> =

> 221 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2 (liber8tion)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 1.1/15.7
> =

> 	=

> =

> 1749 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 16%
> =

> 	=

> =

> 227 MB/s
> =

> Jerasure
> =

> 	=

> =

> 10,2 (cauchy_orig)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.5/1.3
> =

> 	=

> =

> 2066 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 20%
> =

> 	=

> =

> 215 MB/s
> =

> Jerasure
> =

> 	=

> =

> 10,2 (cauchy_orig)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.9/6.2
> =

> 	=

> =

> 2019 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 24%
> =

> 	=

> =

> 175 MB/s
> =

> *Jerasure*
> =

> 	=

> =

> *14,2 (cauchy_orig)*
> =

> 	=

> =

> *OSD*
> =

> 	=

> =

> *PUT*
> =

> 	=

> =

> *4*
> =

> 	=

> =

> *1*
> =

> 	=

> =

> *100*
> =

> 	=

> =

> *64*
> =

> 	=

> =

> *0.5/1.5*
> =

> 	=

> =

> *1872 MB/s*
> =

> 	=

> =

> *4M*
> =

> 	=

> =

> *18%*
> =

> 	=

> =

> *216 MB/s*
> =

> *Jerasure*
> =

> 	=

> =

> *14,2 (cauchy_orig)*
> =

> 	=

> =

> *OSD*
> =

> 	=

> =

> *PUT*
> =

> 	=

> =

> *8*
> =

> 	=

> =

> *2*
> =

> 	=

> =

> *100*
> =

> 	=

> =

> *64*
> =

> 	=

> =

> *1.0/7.4*
> =

> 	=

> =

> *2043 Mb/s*
> =

> 	=

> =

> *4M*
> =

> 	=

> =

> *18%*
> =

> 	=

> =

> *236 MB/s*
> =

> Replication
> =

> 	=

> =

> 2 replica
> =

> 	=

> =

> Host
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.7/8.8
> =

> 	=

> =

> 1198 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 8%
> =

> 	=

> =

> 311 MB/s
> =

> Replication
> =

> 	=

> =

> 2 replica
> =

> 	=

> =

> Host
> =

> 	=

> =

> PUT
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 1.7/33
> =

> 	=

> =

> 1256 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 8%
> =

> 	=

> =

> 327 MB/s
> =

> Jerasure
> =

> 	=

> =

> 9,3
> =

> 	=

> =

> OSD
> =

> 	=

> =

> GET
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.2/0.6
> =

> 	=

> =

> 4338 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 24%
> =

> 	=

> =

> 376 MB/s
> =

> Jerasure
> =

> 	=

> =

> 9,3
> =

> 	=

> =

> OSD
> =

> 	=

> =

> GET
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.2/0.9
> =

> 	=

> =

> 8002 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 54%
> =

> 	=

> =

> 308 MB/s
> =

> Jerasure
> =

> 	=

> =

> 4,1
> =

> 	=

> =

> Host
> =

> 	=

> =

> GET
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.2/0.7
> =

> 	=

> =

> 4630 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 18%
> =

> 	=

> =

> 535 MB/s
> =

> Jerasure
> =

> 	=

> =

> 4,1
> =

> 	=

> =

> Host
> =

> 	=

> =

> GET
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.2/0.7
> =

> 	=

> =

> 8600 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 42%
> =

> 	=

> =

> 426 MB/s
> =

> *Jerasure*
> =

> 	=

> =

> *14,2 (cauchy_orig)*
> =

> 	=

> =

> *OSD*
> =

> 	=

> =

> *GET*
> =

> 	=

> =

> *4*
> =

> 	=

> =

> *1*
> =

> 	=

> =

> *100*
> =

> 	=

> =

> *64*
> =

> 	=

> =

> *0.2/0.7*
> =

> 	=

> =

> *4329 MB/s*
> =

> 	=

> =

> *4M*
> =

> 	=

> =

> *24%*
> =

> 	=

> =

> *375 MB/s*
> =

> Jerasure
> =

> 	=

> =

> 10,2 (cauchy_orig)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> GET
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.2/0.6
> =

> 	=

> =

> 4366 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 19%
> =

> 	=

> =

> 478 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2 (cauchy_orig)
> =

> 	=

> =

> OSD
> =

> 	=

> =

> GET
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.2/0.7
> =

> 	=

> =

> 4370 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 16%
> =

> 	=

> =

> 569 MB/s
> =

> Jerasure
> =

> 	=

> =

> 6,2
> =

> 	=

> =

> OSD
> =

> 	=

> =

> GET
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.2/0.5
> =

> 	=

> =

> 4324 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 20%
> =

> 	=

> =

> 450 MB/s
> =

> Replication
> =

> 	=

> =

> 2 replica
> =

> 	=

> =

> Host
> =

> 	=

> =

> GET
> =

> 	=

> =

> 4
> =

> 	=

> =

> 1
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.2/0.5
> =

> 	=

> =

> 4418 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 8%
> =

> 	=

> =

> 1150 MB/s
> =

> Replication
> =

> 	=

> =

> 2 replica
> =

> 	=

> =

> Host
> =

> 	=

> =

> GET
> =

> 	=

> =

> 8
> =

> 	=

> =

> 2
> =

> 	=

> =

> 100
> =

> 	=

> =

> 64
> =

> 	=

> =

> 0.2/0.9
> =

> 	=

> =

> 8935 MB/s
> =

> 	=

> =

> 4M
> =

> 	=

> =

> 18%
> =

> 	=

> =

> 1034 MB/s
> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

> Summary :
> =

> -------------
> =

>  =

> =

> 1. It is doing pretty good in Reads and 4 Rados Bench clients are saturat=
ing 40 GB network. With more physical server, it is scaling almost linearly=
 and saturating 40 GbE on both the host.
> =

>  =

> =

> 2. As suspected with Ceph, problem is again with writes. Throughput wise =
it is beating replicated pools in significant numbers. But, it is not scali=
ng with multiple clients and not saturating anything.
> =

>  =

> =

>  =

> =

> So, my question is the following.
> =

>  =

> =

> 1. Probably, nothing to do with EC backend, we are suffering because of f=
ilestore inefficiencies. Do you think any tunable like EC stipe size (or an=
ything else) will help here ?
> =

>  =

> =

> 2. I couldn't make fault domain as 'host', because of HW limitation. Do y=
ou think will that play a role in performance for bigger k values ?
> =

>  =

> =

> 3. Even though it is not saturating 40 GbE for writes, do you think separ=
ating out public/private network will help in terms of performance ?
> =

>  =

> =

>  =

> =

> Any feedback on this is much appreciated.
> =

>  =

> =

>  =

> =

> Thanks & Regards
> =

> Somnath
> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

>  =

> =

> =

> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
> =

> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited=
. If you have received this communication in error, please notify the sende=
r by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electr=
onically stored copies).
> =


-- =

Lo=EFc Dachary, Artisan Logiciel Libre
