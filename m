From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner-o+pLhCRhXQuTURD7UP6EnqXJknND6eY5@public.gmane.org>
Subject: Re: OSD disk replacement best practise
Date: Thu, 14 Aug 2014 19:17:41 +0200
Message-ID: <53ECEF35.2080206@smart-weblications.de>
References: <BLU436-SMTP13190B33FCDD9EB1BD24DCEDFE80@phx.gbl>
Reply-To: f.wiessner-o+pLhCRhXQuTURD7UP6EnqXJknND6eY5@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <BLU436-SMTP13190B33FCDD9EB1BD24DCEDFE80-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Guang Yang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Am 14.08.2014 13:29, schrieb Guang Yang:
> Hi cephers,
> Most recently I am drafting the run books for OSD disk replacement, I thi=
nk the rule of thumb is to reduce data migration (recover/backfill), and I =
thought the following procedure should achieve the purpose:
>   1. ceph osd out osd.XXX (mark it out to trigger data migration)
>   2. ceph osd rm osd.XXX
>   3. ceph auth rm osd.XXX
>   4. provision a new OSD which will take XXX as the OSD id and migrate da=
ta back.
> =

> With the above procedure, the crush weight of the host never changed so t=
hat we can limit the data migration only for those which are neccesary.
> =

> Does it make sense?
> =


Looks sane to me, and i remember that i did it that way a few times.


-- =


Mit freundlichen Gr=FC=DFen,

Florian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
