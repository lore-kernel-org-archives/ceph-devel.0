From: Guang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: CEPH's data durability with different configurations
Date: Fri, 18 Apr 2014 20:31:43 +0800
Message-ID: <1CF9B4BD-7917-47AD-BEFE-832D35524F97@yahoo.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: multipart/mixed; boundary="===============1473033601=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1473033601==
Content-Type: multipart/alternative; boundary="Apple-Mail=_7EB93C42-6A00-4F96-9880-AF275060C3B9"


--Apple-Mail=_7EB93C42-6A00-4F96-9880-AF275060C3B9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi all,
One goal of the storage system is to achieve certain durability SLAs, so =
that we replicate data with multiple copies, and check consistency on =
regular basis (e.g. scrubbing), however, replication could increase cost =
(tradeoff between cost & durability), and cluster wide consistency =
checking could bring performance impact (tradeoff between performance & =
durability).

Most recently I am trying to figure out the best configuration for such, =
including:
  1) how many copies do I need? (pool min_size and size)
  2) how frequency should I run scrubbing and deep scrubbing?

Can someone share your experience tuning those numbers and what is the =
durability you can achieve with that?

BTW, S3 claims they have 99.999999999% durability of objects over a =
given year, that seems super high on commodity hardware.

Thanks,
Guang=

--Apple-Mail=_7EB93C42-6A00-4F96-9880-AF275060C3B9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Hi =
all,<div>One goal of the storage system is to achieve certain durability =
SLAs, so that we replicate data with multiple copies, and check =
consistency on regular basis (e.g. scrubbing), however, replication =
could increase cost (tradeoff between cost &amp; durability), and =
cluster wide consistency checking could bring performance impact =
(tradeoff between performance &amp; =
durability).</div><div><br></div><div>Most recently I am trying to =
figure out the best configuration for such, including:</div><div>&nbsp; =
1) how many copies do I need? (pool min_size and size)</div><div>&nbsp; =
2) how frequency should I run scrubbing and deep =
scrubbing?</div><div><br></div><div>Can someone share your experience =
tuning those numbers and what is the durability you can achieve with =
that?</div><div><br></div><div>BTW, S3 claims they have&nbsp;<span =
style=3D"color: rgb(51, 51, 51); font-family: HelveticaNeue, Helvetica, =
Helvetica, Arial, sans-serif; line-height: =
22.399999618530273px;">99.999999999% durability of objects over a given =
year, that seems super high on commodity =
hardware.</span></div><div><span style=3D"color: rgb(51, 51, 51); =
font-family: HelveticaNeue, Helvetica, Helvetica, Arial, sans-serif; =
line-height: 22.399999618530273px;"><br></span></div><div><span =
style=3D"color: rgb(51, 51, 51); font-family: HelveticaNeue, Helvetica, =
Helvetica, Arial, sans-serif; line-height: =
22.399999618530273px;">Thanks,</span></div><div><span style=3D"color: =
rgb(51, 51, 51); font-family: HelveticaNeue, Helvetica, Helvetica, =
Arial, sans-serif; line-height: =
22.399999618530273px;">Guang</span></div></body></html>=

--Apple-Mail=_7EB93C42-6A00-4F96-9880-AF275060C3B9--

--===============1473033601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1473033601==--
