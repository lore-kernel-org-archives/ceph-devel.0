From: Sergey Malinin <hell-cDpxXvEWlHVBDgjK7y7TUQ@public.gmane.org>
Subject: Re: v0.80 Firefly released
Date: Sun, 11 May 2014 15:32:58 +0300
Message-ID: <28FAEC23AD3B41769665F6DF6750500F@newmail.com>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net>
	<536A54C6.4060202@cern.ch>
	<CAPYLRzhyt3i0sXOGrqZxzrH02+VOjBeMS37xk8ua2K2C2oydkw@mail.gmail.com>
	<536A78F3.8020607@cloudapt.com>
	<CABYiri9GJjbOEzzHjUAa1nBmah0nr1AoY17q1Vb=cwih+aE+WA@mail.gmail.com>
	<536D4D48.5040307@cloudapt.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0797767465=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <536D4D48.5040307-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mike Dawson <mike.dawson-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0797767465==
Content-Type: multipart/alternative; boundary="536f6dfa_333ab105_3767"

--536f6dfa_333ab105_3767
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> 
> # ceph tell mon.* injectargs '--mon_osd_allow_primary_affinity true'
> 
> Ignore the "mon.a: injectargs: failed to parse arguments: true" 
> warnings, this appears to be a bug [0].
> 
> 

It will work this way: 
ceph tell mon.* injectargs -- --mon_osd_allow_primary_affinity=true


--536f6dfa_333ab105_3767
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


                <blockquote type=3D=22cite=22 style=3D=22border-left-styl=
e:solid;border-width:1px;margin-left:0px;padding-left:10px;=22><span><div=
><div><div><br></div><div>=23 ceph tell mon.* injectargs '--mon=5Fosd=5Fa=
llow=5Fprimary=5Faffinity true'</div><div><br></div><div>Ignore the =22mo=
n.a: injectargs: failed to parse arguments: true=22 </div><div>warnings, =
this appears to be a bug =5B0=5D.</div></div></div></span></blockquote><d=
iv>It will work this way:
                </div><div>ceph tell mon.* injectargs -- --mon=5Fosd=5Fal=
low=5Fprimary=5Faffinity=3Dtrue</div><div><br></div>
            
--536f6dfa_333ab105_3767--


--===============0797767465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0797767465==--
