From: yiming xie <platoxym@gmail.com>
Subject: Re: librgw init failed (-5)
Date: Tue, 11 Oct 2016 11:05:45 +0800
Message-ID: <159FD7C6-5997-4D34-B975-B17490C847F4@gmail.com>
References: <7C82F41C-1C24-4D78-B79B-E7B3BE012FE7@gmail.com> <1368180094.4143928.1476107623758.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35279 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753245AbcJKDOm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Oct 2016 23:14:42 -0400
Received: by mail-pa0-f49.google.com with SMTP id qn10so6690284pac.2
        for <ceph-devel@vger.kernel.org>; Mon, 10 Oct 2016 20:14:42 -0700 (PDT)
In-Reply-To: <1368180094.4143928.1476107623758.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi,matt:

I will try to start nfs-ganesha according your ganesha.conf with my =
private parameters.
I created ganesha.conf according to =
=A1=B0/usr/share/doc/ganesha/config_samples/rgw.conf=A1=B1.
The all contents of ganesha.conf:
EXPORT
{
        Export_ID=3D1;

        Path =3D "/";

        Pseudo =3D "/";

        Access_Type =3D RW;

        NFS_Protocols =3D 4;

        Transport_Protocols =3D TCP;

        FSAL {
                Name =3D RGW;
                User_Id =3D "admin";
                Access_Key_Id =3D"admin";
                Secret_Access_Key =3D "admin";
        }
}

RGW {
    ceph_conf =3D "/etc/ceph/ceph.conf";
}
=20
The all contents of /etc/ceph/ceph.conf:
[global]
fsid =3D 9dddf9d6-951b-4da7-9943-7eb7623dc2f4
mon_initial_members =3D node2
mon_host =3D 172.16.121.132
auth_cluster_required =3D cephx
auth_service_required =3D cephx
auth_client_required =3D cephx
osd_pool_default_size =3D 2

Best regards
Yiming xie


> =D4=DA 2016=C4=EA10=D4=C210=C8=D5=A3=AC=CF=C2=CE=E79:53=A3=ACMatt =
Benjamin <mbenjamin@redhat.com> =D0=B4=B5=C0=A3=BA
>=20
> Hi Yiming,
>=20
> Can you share the contents of the RGW and FSAL blocks of your =
ganesha.conf?
>=20
> For comparison, here's one that I use (keys sanitized):
>=20
> """
> EXPORT
> {
> 	# Export Id (mandatory, each EXPORT must have a unique =
Export_Id)
> 	Export_Id =3D 77;
>=20
> 	# Exported path (mandatory)
> 	Path =3D "/";
>=20
> 	# Pseudo Path (required for NFS v4)
> 	Pseudo =3D "/";
>=20
> 	# Required for access (default is None)
> 	# Could use CLIENT blocks instead
> 	Access_Type =3D RW;
>=20
> 	SecType =3D "sys";
>=20
> 	Protocols =3D 3,4;
>=20
> 	#Delegations =3D Readwrite;
>=20
> 	Squash =3D No_Root_Squash;
>=20
> 	# Exporting FSAL
> 	FSAL {
> 		Name =3D RGW;
> 		User_Id =3D "testuser";
> 		Access_Key_Id =3D "acckey";
> 		Secret_Access_Key =3D "secretkey";
> 	}
> }
>=20
> RGW {
>    ceph_conf =3D "/opt/ceph-rgw/etc/ceph/ceph.conf";
>    init_args =3D "-d --debug-rgw=3D16";
> }
>=20
> NFS_Core_Param
> {
>        Nb_Worker =3D 12;
> }
>=20
> NFSV4 {
>    Graceless =3D true;
>    Allow_Numeric_Owners =3D true;
>    Only_Numeric_Owners =3D true;
> }
>=20
> LOG {
> 	# Default_Log_Level is unknown token??
> 	#Default_Log_Level =3D NIV_FULL_DEBUG;
> 	Components {
> 		#ALL =3D FULL_DEBUG;
> 		MEMLEAKS =3D FATAL;
> 		FSAL =3D FULL_DEBUG;
> 		NFSPROTO =3D FATAL;
> 		NFS_V4 =3D FATAL;
> 		EXPORT =3D FATAL;
> 		FILEHANDLE =3D FATAL;
> 		DISPATCH =3D FATAL;
> 		CACHE_INODE =3D FATAL;
> 		CACHE_INODE_LRU =3D FATAL;
> 		HASHTABLE =3D FATAL;
> 		HASHTABLE_CACHE =3D FATAL;
> 		DUPREQ =3D FATAL;
> 		INIT =3D DEBUG;
> 		MAIN =3D DEBUG;
> 		IDMAPPER =3D FATAL;
> 		NFS_READDIR =3D FATAL;
> 		NFS_V4_LOCK =3D FATAL;
> 		CONFIG =3D FATAL;
> 		CLIENTID =3D FATAL;
> 		SESSIONS =3D FATAL;
> 		PNFS =3D FATAL;
> 		RW_LOCK =3D FATAL;
> 		NLM =3D FATAL;
> 		RPC =3D FATAL;
> 		NFS_CB =3D FATAL;
> 		THREAD =3D FATAL;
> 		NFS_V4_ACL =3D FATAL;
> 		STATE =3D FATAL;
> #		9P =3D FATAL;
> #		9P_DISPATCH =3D FATAL;
> 		FSAL_UP =3D FATAL;
> 		DBUS =3D FATAL;
> 	}
> 	Facility {
> 		name =3D FILE;
> 		destination =3D "/tmp/ganesha-rgw.log";
> 		enable =3D active;
> 	}
> }
> """
>=20
> Regards,
>=20
> Matt
>=20
> ----- Original Message -----
>> From: "yiming xie" <platoxym@gmail.com>
>> To: ceph-devel@vger.kernel.org
>> Cc: "Matt Benjamin" <mbenjamin@redhat.com>
>> Sent: Saturday, October 8, 2016 3:23:31 AM
>> Subject: librgw init failed (-5)
>>=20
>> I start nfs-ganesha with FSAL_RGW failed, the nfs-ganesha log is:
>> "create_export :FSAL :CRIT :RGW module: librgw init failed (-5)=A1=B1
>>=20
>> ceph/src/rgw/librgw.cc:
>> int librgw_create(librgw_t* rgw, int argc, char **argv)
>> this interface return value equal -5 and it=A1=AFs parameters as =
below:
>>=20
>> argc=3D2
>> argv[0] =3D =A1=B0nfs-ganesha=A1=B1
>> argv[1] =3D =A1=B0--conf=3D/etc/ceph/ceph.conf=A1=B1
>>=20
>> env:
>> nfs-genahsa(2.3)
>> librgw.so.2.0.0
>=20
> --=20
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>=20
> http://www.redhat.com/en/technologies/storage
>=20
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
> H

