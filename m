From: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Subject: Re: less cores more iops / speed
Date: Mon, 12 Nov 2012 16:39:35 +0100 (CET)
Message-ID: <1dd68f20-8ab8-450f-856b-5dcb1b0dd29b@mailpro>
References: <50A116DC.2020509@profihost.ag>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1956898628=="
Return-path: <pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org>
In-Reply-To: <50A116DC.2020509-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://pve.proxmox.com/cgi-bin/mailman/options/pve-devel>,
	<mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://pve.proxmox.com/pipermail/pve-devel>
List-Post: <mailto:pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org>
List-Help: <mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=help>
List-Subscribe: <http://pve.proxmox.com/cgi-bin/mailman/listinfo/pve-devel>,
	<mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=subscribe>
Sender: pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
Errors-To: pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
To: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1956898628==
Content-Type: multipart/alternative;
 boundary="=_3739ebeb-cff7-4f7f-956a-04a92de5c9c4"

--=_3739ebeb-cff7-4f7f-956a-04a92de5c9c4
Content-Type: multipart/related;
 boundary="=_af6f00af-8ee9-45ea-a45e-4a0c429e3dda"

--=_af6f00af-8ee9-45ea-a45e-4a0c429e3dda
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

maybe this is debug perfcounter ? 





----- Mail original ----- 

De: "Stefan Priebe - Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> 
=C3=80: "Alexandre DERUMIER" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org> 
Cc: pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
Envoy=C3=A9: Lundi 12 Novembre 2012 16:33:48 
Objet: Re: [pve-devel] less cores more iops / speed 

Adding this to ceph.conf on kvm host adds another 2000 iops (20.000 
iop/s with one VM). I'm sure most of them are useless on a client kvm / 
rbd host but i don't know which one makes sense ;-) 

[global] 
debug ms =3D 0/0 
debug rbd =3D 0/0 
debug lockdep =3D 0/0 
debug context =3D 0/0 
debug crush =3D 0/0 
debug buffer =3D 0/0 
debug timer =3D 0/0 
debug journaler =3D 0/0 
debug osd =3D 0/0 
debug optracker =3D 0/0 
debug objclass =3D 0/0 
debug filestore =3D 0/0 
debug journal =3D 0/0 
debug ms =3D 0/0 
debug monc =3D 0/0 
debug tp =3D 0/0 
debug auth =3D 0/0 
debug finisher =3D 0/0 
debug heartbeatmap =3D 0/0 
debug perfcounter =3D 0/0 
debug asok =3D 0/0 
debug throttle =3D 0/0 

[client] 
debug ms =3D 0/0 
debug rbd =3D 0/0 
debug lockdep =3D 0/0 
debug context =3D 0/0 
debug crush =3D 0/0 
debug buffer =3D 0/0 
debug timer =3D 0/0 
debug journaler =3D 0/0 
debug osd =3D 0/0 
debug optracker =3D 0/0 
debug objclass =3D 0/0 
debug filestore =3D 0/0 
debug journal =3D 0/0 
debug ms =3D 0/0 
debug monc =3D 0/0 
debug tp =3D 0/0 
debug auth =3D 0/0 
debug finisher =3D 0/0 
debug heartbeatmap =3D 0/0 
debug perfcounter =3D 0/0 
debug asok =3D 0/0 
debug throttle =3D 0/0 

Stefan 

Am 12.11.2012 15:35, schrieb Alexandre DERUMIER: 
> Another idea, 
> 
> do you have tried to put 
>>>>> debug lockdep =3D 0/0 
>>>>> debug context =3D 0/0 
>>>>> debug crush =3D 0/0 
>>>>> debug buffer =3D 0/0 
>>>>> debug timer =3D 0/0 
>>>>> debug journaler =3D 0/0 
>>>>> debug osd =3D 0/0 
>>>>> debug optracker =3D 0/0 
>>>>> debug objclass =3D 0/0 
>>>>> debug filestore =3D 0/0 
>>>>> debug journal =3D 0/0 
>>>>> debug ms =3D 0/0 
>>>>> debug monc =3D 0/0 
>>>>> debug tp =3D 0/0 
>>>>> debug auth =3D 0/0 
>>>>> debug finisher =3D 0/0 
>>>>> debug heartbeatmap =3D 0/0 
>>>>> debug perfcounter =3D 0/0 
>>>>> debug asok =3D 0/0 
>>>>> debug throttle =3D 0/0 
> 
> in a ceph.conf on your kvm host ? 
> 
> 
> ----- Mail original ----- 
> 
> De: "Alexandre DERUMIER" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org> 
> =C3=80: "Stefan Priebe - Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> 
> Cc: pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org 
> Envoy=C3=A9: Lundi 12 Novembre 2012 15:26:36 
> Objet: Re: [pve-devel] less cores more iops / speed 
> 
> Maybe some tracing on kvm process could give us clues to find where the c=
pu is used ? 
> 
> Also another idea, can you try with "auth supported=3Dnone" ? maybe they =
are some overhead with ceph authenfication ? 
> 
> 
> 
> 
> ----- Mail original ----- 
> 
> De: "Alexandre DERUMIER" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org> 
> =C3=80: "Stefan Priebe - Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> 
> Cc: pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org 
> Envoy=C3=A9: Lundi 12 Novembre 2012 15:20:07 
> Objet: Re: [pve-devel] less cores more iops / speed 
> 
> Ok thanks. 
> 
> Seem to use a lot of cpu vs nfs,iscsi ... 
> 
> I hope that ceph dev will work on this soon ! 
> 
> 
> ----- Mail original ----- 
> 
> De: "Stefan Priebe - Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> 
> =C3=80: "Alexandre DERUMIER" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org> 
> Cc: "eric" <eric-9y2FTvk76rRBDgjK7y7TUQ@public.gmane.org>, pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org 
> Envoy=C3=A9: Lundi 12 Novembre 2012 15:05:08 
> Objet: Re: [pve-devel] less cores more iops / speed 
> 
> Am 12.11.2012 13:49, schrieb Alexandre DERUMIER: 
>>>> One VM on one Host: 18.000 IOP/s 
>>>> Two VM on one Host: 2x11.000 IOP/s 
>>>> Three VM on one Host: 3x7.000 IOP/s 
>> 
>> And host cpu is 100% ? 
> 
> No. For three VMs yes. For one and two no. I think librbd / rbd 
> implementation in kvm is the bottleneck here. 
> 
> Stefan 
> 
>> ----- Mail original ----- 
>> 
>> De: "Stefan Priebe - Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> 
>> =C3=80: "Alexandre DERUMIER" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org> 
>> Cc: "eric" <eric-9y2FTvk76rRBDgjK7y7TUQ@public.gmane.org>, pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org 
>> Envoy=C3=A9: Lundi 12 Novembre 2012 12:58:35 
>> Objet: Re: [pve-devel] less cores more iops / speed 
>> 
>> Am 12.11.2012 08:51, schrieb Alexandre DERUMIER: 
>>>>> Right now RBD in KVM is limited by CPU speed. 
>>> 
>>> Good to known, so it's seem lack of threading, or maybe somes locks. (s=
o faster cpu give more iops). 
>>> 
>>> If you lauch parallel fio on same host on different guest, do you get m=
ore total iops ? (for me it's scale) 
>> 
>> One VM on one Host: 18.000 IOP/s 
>> Two VM on one Host: 2x11.000 IOP/s 
>> Three VM on one Host: 3x7.000 IOP/s 
>> 
>>> if you launch 2 parallel fio, on same guest (on differents disk), do yo=
u get more iops ? (for me, it doesn't scale, so raid0 in guest doesn't help=
). 
>> No it doesn't scale. 
>> 
>> Stefan 
>> 
>>> ----- Mail original ----- 
>>> 
>>> De: "Stefan Priebe" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> 
>>> =C3=80: "Alexandre DERUMIER" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org> 
>>> Cc: "eric" <eric-9y2FTvk76rRBDgjK7y7TUQ@public.gmane.org>, pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org 
>>> Envoy=C3=A9: Dimanche 11 Novembre 2012 13:07:36 
>>> Objet: Re: [pve-devel] less cores more iops / speed 
>>> 
>>> Am 11.11.2012 12:12, schrieb Alexandre DERUMIER: 
>>>> If I remember good, stefan can achieve 100.000 iops with iscsi with sa=
me kvm host. 
>>> 
>>> Correct but this was always with scsi-generic and I/O multipathing on 
>>> host. rbd does not support scsi-generic ;-( 
>>> 
>>>> I have checked ceph mailing, stefan seem to have resolved his problem =
with dual core with bios update ! 
>>> Correct. So speed on Dual Xeon is now 14.000 IOP/s and 18.000 IOP/s on =

>>> Single Xeon. But the difference is an issue of the CPU Speed. 3,6Ghz 
>>> Single Xeon vs. 2.5Ghz Dual Xeon. 
>>> 
>>> Right now RBD in KVM is limited by CPU speed. 
>>> 
>>> Greets, 
>>> Stefan 
>>> 
> _______________________________________________ 
> pve-devel mailing list 
> pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org 
> http://pve.proxmox.com/cgi-bin/mailman/listinfo/pve-devel 
> _______________________________________________ 
> pve-devel mailing list 
> pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org 
> http://pve.proxmox.com/cgi-bin/mailman/listinfo/pve-devel 
> 
--=_af6f00af-8ee9-45ea-a45e-4a0c429e3dda--

--=_3739ebeb-cff7-4f7f-956a-04a92de5c9c4--

--===============1956898628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pve-devel mailing list
pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
http://pve.proxmox.com/cgi-bin/mailman/listinfo/pve-devel

--===============1956898628==--
