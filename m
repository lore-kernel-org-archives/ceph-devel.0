From: Dan van der Ster <daniel.vanderster-vJEk5272eHo@public.gmane.org>
Subject: Re: v0.80 Firefly released
Date: Wed, 7 May 2014 17:44:06 +0200
Message-ID: <536A54C6.4060202@cern.ch>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1323974879=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1405061757540.28165-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1323974879==
Content-Type: multipart/alternative;
	boundary="------------040001030608040907060301"

--------------040001030608040907060301
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Sage Weil wrote:
> **Primary affinity*: Ceph now has the ability to skew selection of
>    OSDs as the "primary" copy, which allows the read workload to be
>    cheaply skewed away from parts of the cluster without migrating any
>    data.

Can you please elaborate a bit on this one? I found the blueprint [1] 
but still don't quite understand how it works. Does this only change the 
crush calculation for reads? i.e writes still go to the usual primary, 
but reads are distributed across the replicas? If so, does this change 
the consistency model in any way.

Cheers, Dan



[1] 
http://wiki.ceph.com/Planning/Blueprints/Firefly/osdmap%3A_primary_role_affinity

--------------040001030608040907060301
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<html><head>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
</head><body bgcolor="#FFFFFF" text="#000000">Hi,<br>
<br>
Sage Weil wrote:
<blockquote 
cite="mid:alpine.DEB.2.00.1405061757540.28165-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org" 
type="cite">
  <pre wrap="">* <b class="moz-txt-star"><span class="moz-txt-tag">*</span>Primary affinity<span class="moz-txt-tag">*</span></b>: Ceph now has the ability to skew selection of
  OSDs as the "primary" copy, which allows the read workload to be
  cheaply skewed away from parts of the cluster without migrating any
  data.</pre>
</blockquote>
<br>
Can you please elaborate a bit on this one? I found the blueprint [1] 
but still don't quite understand how it works. Does this only change the
 crush calculation for reads? i.e writes still go to the usual primary, 
but reads are distributed across the replicas? If so, does this change 
the consistency model in any way.<br>
<br>
Cheers, Dan<br>
<br>
<br>
<br>
[1] 
<a class="moz-txt-link-freetext" href="http://wiki.ceph.com/Planning/Blueprints/Firefly/osdmap%3A_primary_role_affinity">http://wiki.ceph.com/Planning/Blueprints/Firefly/osdmap%3A_primary_role_affinity</a><br>
</body></html>

--------------040001030608040907060301--

--===============1323974879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1323974879==--
