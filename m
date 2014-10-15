From: Amon Ott <a.ott-oFjU9DtLk10Mb+B85CZM8Q@public.gmane.org>
Subject: Re: the state of cephfs in giant
Date: Wed, 15 Oct 2014 08:43:42 +0200
Message-ID: <543E179E.4070704@m-privacy.de>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net>
	<543CD16C.6060708@m-privacy.de>
	<alpine.DEB.2.00.1410140718050.10462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1410140718050.10462-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Amon Ott <a.ott-oFjU9DtLk10Mb+B85CZM8Q@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Am 14.10.2014 16:23, schrieb Sage Weil:
> On Tue, 14 Oct 2014, Amon Ott wrote:
>> Am 13.10.2014 20:16, schrieb Sage Weil:
>>> We've been doing a lot of work on CephFS over the past few months. This
>>> is an update on the current state of things as of Giant.
>> ...
>>> * Either the kernel client (kernel 3.17 or later) or userspace (ceph-fu=
se
>>>   or libcephfs) clients are in good working order.
>>
>> Thanks for all the work and specially for concentrating on CephFS! We
>> have been watching and testing for years by now and really hope to
>> change our Clusters to CephFS soon.
>>
>> For kernel maintenance reasons, we only want to run longterm stable
>> kernels. And for performance reasons and because of severe known
>> problems we want to avoid Fuse. How good are our chances of a stable
>> system with the kernel client in the latest longterm kernel 3.14? Will
>> there be further bugfixes or feature backports?
> =

> There are important bug fixes missing from 3.14.  IIRC, the EC, cache =

> tiering, and firefly CRUSH changes aren't there yet either (they landed i=
n =

> 3.15), and that is not appropriate for a stable series.
> =

> They can be backported, but no commitment yet on that :)

If the bugfixes are easily identified in one of your Ceph git branches,
I would even try to backport them myself. Still, I would rather see
someone from the Ceph team with deeper knowledge of the code port them.

IMHO, it would be good for Ceph to have stable support in at least the
latest longterm kernel. No need for new features, but bugfixes should be
there.

Amon Ott
-- =

Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Werner-Vo=DF-Damm 62       Fax: +49 30 99296856
12101 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
