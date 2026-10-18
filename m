Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7016E21FF23
	for <ceph-devel@vger.kernel.org>; Sun, 18 Oct 2026 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792319951; cv=pass; b=RQ5dGiIh2B9DLO4szvYu5Nnfs216MjvFJSK49E9syq3GOCwwjj3iM7/nx68SufXK9UovM7GkTOKZfjN3NoeuI8DfzfjSrbwMTqj8YyAwQnNaqhSyyI0RdiE/xLdEMs4aJih+Bzgrk1OfanckgwRIKktoNxN+ekRvyOlf228l4D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792319951; c=relaxed/simple;
	bh=Ix4hUh79tnqP7nrq8I+0E55MOm8MLDc2B5exNIFPWZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMNYJgD2w4to1EoPTPFyl5BMb/4qBbrgokBmHzEcXu2QXR5GouKPp4BaZKJH8avtRrVH+9YZoHxv+iduv1DxTquh6SRt23/Slb/vOuf2wH0cxxmlC691oxFIZgEJhQoX7nFZNHX6lKyLFRmOIiwlaZvBeCsNDPjX4n1NcVQG7+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Il1N03VB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYlOkkOv; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il1N03VB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYlOkkOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792319948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXhzKE/EI1dMTWZ8ZhzLb8Wvaw8iwiOzu8UPd6uHesY=;
	b=Il1N03VBfKOxQ6M1Q62ke24DfT61rzfi9cqgX0ZVNrltR473Ew0TMn8N6xrhqKLopUcLSC
	LhHuiuLMhrFuQX4VBPUyIboFS0QSovdnmcVe61+dejZony+UAoEXj3HDnxhU1b+ewgZzAN
	0D53XVg2MbC3qkFxi/B91XYQ60TkUn8=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-iYUwboOUPDS0BWmf7vTzMg-1; Sun, 18 Oct 2026 10:39:07 +0000
X-MC-Unique: iYUwboOUPDS0BWmf7vTzMg-1
X-Mimecast-MFC-AGG-ID: iYUwboOUPDS0BWmf7vTzMg_1792319946
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7c0f07b4e81so438460137.2
        for <ceph-devel@vger.kernel.org>; Sun, 18 Oct 2026 03:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792319946; cv=none;
        d=google.com; s=arc-20260327;
        b=XHqRuAmNS2WCow6go2rTGPOZEfsKE+aPMtP0k626WtiDJrJ8CR/ySojKJxMzNSvUC5
         jgJpjA7NkEPhoUblR1DVMCtx1iqPm8BZ+lMBqB+mYDrGDwUzNUa4O28Ku82sv7X96rEd
         zNH3t57tCUkGZowht2tvZdZ9pDS/YLdo0JO+eWBB+oYBIUBp8ALsAz8RR/oUNBl6pNMe
         Fb+Gw3q4MzHSEnZpaZb2wpU1pX2yFWd1P5dMcCPIVe3dXAUDi9uB1T2G+sA6YcxOEvlv
         IxgDMv020CYqCff0LTktzDgXEs3MFYyMO/QgQNP+9gKxcEFoq6jA6DfUC6rD/KWYK1sH
         UmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vXhzKE/EI1dMTWZ8ZhzLb8Wvaw8iwiOzu8UPd6uHesY=;
        fh=9j8SU2F2wLsxHTJB55qG9lqVlNJD0ftXxrDnJ/GqZXo=;
        b=Tw3kSGfgQlzgsW4TF+F4cC/wiygkmH0wEOxIWgLAsuRszMS7JgZkoMtlJdLr2Zfe4/
         VxO8sxhUCkq1n7dankMYXFHKhyVTsBTQmzmroNUP94t9OVcaUdeOBhF7aR546aUWe3xC
         R/iZJJLa8TQz9SBGzXsrolTpO/XjzI8O9treQDtJ9OC8d5viypoKc6H+EtwacNtYN+Hz
         Is3Oc8TPN9nyp3EN8UbgQ8gbd6g09+0BdaLnLMHI5XLtQURns6gA2vM3hDh59mqU2QkK
         h91Y0VVR0vhbaLDaddMFMGvcEccbaPPlBHeVPaUyK3n2HaE4XFXmaNRm/DLyioR9CAeF
         CLEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792319946; x=1792924746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vXhzKE/EI1dMTWZ8ZhzLb8Wvaw8iwiOzu8UPd6uHesY=;
        b=gYlOkkOvgdje9+tKjBJ4tCyzfyi07uNhjf8nrsEhGOeww+OFfduWYGuDDY+hIfF5Og
         ARmEazicoRHAE3iCuMJMg2YMnyqdI0Y9SUQZ2g7gVAbKOWivc3/3CYTbyBsHcSvl/yQq
         CKo627SxFHuRbfxeGDLKIGW2pguNuPGl00ART6M48TxyRY+SZU5GKOvYL7WCXWP+cF6T
         EbK32EXVYAV9uHRYoZbsPsNqCqu3NuWqxQ2VTp5N5ENc+uWf34jSMuXNgRKPrBnzyowQ
         6qCGoZ0JGUxw9XpHR+qL1iWLYw3kSxIGFMpikPVgJCJjHt3H7ELFKw3tvrecHPw1fd3B
         +NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792319946; x=1792924746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vXhzKE/EI1dMTWZ8ZhzLb8Wvaw8iwiOzu8UPd6uHesY=;
        b=ALPmXFUmlob3GGByIvlgdlkZzITIc5JNbuEbpCCB6hoMbypCinyPCnnxGXInVRCda4
         wF8vLUnU5ds9yHQdw64kS2tG4QfVJbs705dH1n9wIcId496+ScsPVhEgIgPRnq47IZt4
         CuwEH51AOs1UmcTlgb3h1tQ4zLrvlw+B6fvZgvPT1PVB0c0LHvcWrNr6n8HXIcs8WI4W
         CBIZS/O71CGfPMlMCW7REsDvWRsXdJu1pJIAmfq0BbHwwvKqu9esuM8xm5ubeKoCkxcZ
         Kc/ZajOt1N1sB9sdkXQYf2hBJ7ypiJ8AGtO8Z2ShyWca9obpSD2RQITQhNlIPW5PZRtZ
         vIww==
X-Gm-Message-State: AFq9FYJF+1KULiSgn2CdnierT2l4QtSGE9+epBX0ef6IotRrWJW5qQng
	d/oSLRAptQWf1C2LnG/RsBfrDmYo5gM78cJZ2kTug+TQ+1SXf3zmo1QuAphHMVjIOkwjTq7NK8O
	P6DyyMRx+6O+d5JHVNYmSrn4vE37PDNO1Zw19jrvA4DpzovNyx9MI/1X6SBoGRYTZl3OoIBOH8i
	hu2LIuBfgaP1k9pxf4XlO7+7sbKdjQ1DohQ8omq2oAU6xvxliX
X-Gm-Gg: AYBFou2B1uJcr5CisTmackAJzVfB5UX6a5Yx+iaJtWXCREfrUvLQ0jhsPD8TAKLu3gi
	HoKKWs4aKSsOKJl1mmPhvZnJ8xnG1QW1p66Usg6RDUejqGbrPMXzoqEAm11hgF3ev8BhPD5yeUe
	aJ0eOxTdnEEzdIK00ZctSWons6uMVjJb6ONaxRvmwaRYOhZms9ey6VkfAoe3coow78JrkGlkSXL
	DKa9f5trx/0nDcOUP5DWScSYYkWu/dvqJjnEyokkgu9G6L06JF4ZR30l0g2od57vfVT3WNt7Hbb
	a03bherTOVLbBbH0+GT+k7CsbQ==
X-Received: by 2002:a05:6102:5488:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7cc36a207e5mr1098958137.24.1792319946334;
        Sun, 18 Oct 2026 03:39:06 -0700 (PDT)
X-Received: by 2002:a05:6102:5488:b0:7a7:5355:7fb6 with SMTP id
 ada2fe7eead31-7cc36a207e5mr1098955137.24.1792319945792; Sun, 18 Oct 2026
 03:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792074165.git.amarkuze@redhat.com> <cover.1792241577.git.amarkuze@redhat.com>
 <e0ed00e6d17dc8c6603c7de42d4e7b48d483274b.1792241577.git.amarkuze@redhat.com> <20261017162340.GI989762@ZenIV>
In-Reply-To: <20261017162340.GI989762@ZenIV>
From: Alex Markuze <amarkuze@redhat.com>
Date: Sun, 18 Oct 2026 13:38:54 +0300
X-Gm-Features: AclHuK-lFJBzF7MF8NVq33jOUM2sJkUgv8o74eRkQJHZAmx2RYeU5kVieoVCuig
Message-ID: <CAO8a2ShntDoqhh94CT5taf0GzwxRLr8bdevYjy8YCW9BZvnc8Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ceph: fail quarantined subvolume access with EACCES
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, xiubo.li@clyso.com, 
	slava@dubeyko.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 7:32=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> > +/* A snapshot path must reach a head inode to encode its snapshot name=
. */
> > +static bool ceph_snapshot_has_path(struct inode *inode)
> > +{
> > +     struct dentry *alias =3D d_find_alias(inode);
> > +     struct dentry *cur;
> > +     unsigned int seq, depth =3D 0;
> > +     bool connected =3D false;
> > +
> > +     if (!alias)
> > +             return false;
> > +
> > +     rcu_read_lock();
> > +     seq =3D read_seqbegin(&rename_lock);
> > +     cur =3D alias;
> > +     while (cur && depth++ < 256) {
> > +             struct inode *in =3D d_inode_rcu(cur);
> > +             struct dentry *parent;
> > +
> > +             if (!in)
> > +                     break;
> > +             if (!ceph_in_snap(in)) {
> > +                     connected =3D true;
> > +                     break;
> > +             }
> > +             if (d_unhashed(cur) ||
> > +                 (READ_ONCE(cur->d_flags) & DCACHE_DISCONNECTED))
> > +                     break;
> > +             parent =3D READ_ONCE(cur->d_parent);
> > +             if (!parent || parent =3D=3D cur)
>                     ^^^^^^^
> Please, explain how could that possibly happen.

This can't happen in the code as currently written; it's a cheap redundancy=
.

> > +                     break;
> > +             cur =3D parent;
> > +     }
> > +     if (read_seqretry(&rename_lock, seq))
> > +             connected =3D false;
> > +     rcu_read_unlock();
> > +     dput(alias);
> > +     return connected;
> > +}
> > +
> > +static int ceph_snapshot_reply_error(struct inode *inode,
> > +                                  struct ceph_mds_request *req, int ma=
sk)
> > +{
> > +     struct ceph_inode_info *ci =3D ceph_inode(inode);
> > +     bool have_xattrs;
> > +
> > +     if (!req->r_target_inode ||
> > +         ceph_ino(req->r_target_inode) !=3D ceph_ino(inode) ||
> > +         ceph_snap(req->r_target_inode) !=3D ceph_snap(inode))
> > +             return -EOPNOTSUPP;
> > +
> > +     /* LOOKUPINO can authorize access without returning the requested=
 blob. */
> > +     if ((mask & CEPH_CAP_XATTR_SHARED) &&
> > +         req->r_reply_info.targeti.xattr_len < 4) {
> > +             spin_lock(&ci->i_ceph_lock);
> > +             have_xattrs =3D ci->i_xattrs.version !=3D 0;
> > +             spin_unlock(&ci->i_ceph_lock);
> > +             if (!have_xattrs)
> > +                     return -EOPNOTSUPP;
> > +     }
> > +     if ((mask & CEPH_CAP_FILE_RD) &&
> > +         req->r_reply_info.targeti.inline_version =3D=3D 0 &&
> > +         ceph_has_inline_data(ci) && i_size_read(inode) > 0)
> > +             return -EOPNOTSUPP;
> > +     return 0;
> > +}
> > +
> > +static int ceph_snapshot_lookupino(struct inode *inode,
> > +                                struct folio *locked_folio, int mask)
> > +{
> > +     struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(inode->i_sb);
> > +     struct ceph_mds_request *req;
> > +     int err;
> > +
> > +     req =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPINO, USE=
_ANY_MDS);
> > +     if (IS_ERR(req))
> > +             return PTR_ERR(req);
> > +     /* No r_inode: an NFS alias may not encode a snapshot pathname. *=
/
> > +     req->r_ino1 =3D ceph_vino(inode);
> > +     req->r_args.lookupino.snapid =3D cpu_to_le64(ceph_snap(inode));
> > +     req->r_args.lookupino.mask =3D cpu_to_le32(mask);
> > +     req->r_num_caps =3D 1;
> > +     req->r_locked_folio =3D locked_folio;
> > +     err =3D ceph_mdsc_do_request(mdsc, NULL, req);
> > +     if (!err)
> > +             err =3D ceph_snapshot_reply_error(inode, req, mask);
> > +     if (locked_folio && !err) {
> > +             u64 version =3D req->r_reply_info.targeti.inline_version;
> > +
> > +             if (version =3D=3D 0)
> > +                     err =3D -EINVAL;
> > +             else if (version =3D=3D CEPH_INLINE_NONE || version =3D=
=3D 1)
> > +                     err =3D -ENODATA;
> > +             else
> > +                     err =3D req->r_reply_info.targeti.inline_len;
> > +     }
> > +     ceph_mdsc_put_request(req);
> > +     return err;
> > +}
> > +
> > +int ceph_snapshot_read_auth(struct inode *inode)
> > +{
> > +     /*
> > +      * Preserve a connected snapshot path: its head inode may have be=
en
> > +      * deleted and no longer be cached by the MDS. Disconnected handl=
es
> > +      * fall back to LOOKUPINO, with the exact inode and snapshot ID.
> > +      * The authorization is scoped to this operation, never cached.
> > +      */
> > +     return ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, true);
> > +}
> > +
> >  /*
> >   * Verify that we have a lease on the given mask.  If not,
> >   * do a getattr against an mds.
> > @@ -3582,20 +3863,43 @@ int __ceph_do_getattr(struct inode *inode, stru=
ct folio *locked_folio,
> >       struct ceph_client *cl =3D fsc->client;
> >       struct ceph_mds_client *mdsc =3D fsc->mdsc;
> >       struct ceph_mds_request *req;
> > +     u64 qepoch;
> >       int mode;
> >       int err;
> >
> >       if (ceph_snap(inode) =3D=3D CEPH_SNAPDIR) {
> > +             struct inode *parent;
> > +
> >               boutc(cl, "inode %p %llx.%llx SNAPDIR\n", inode,
> >                     ceph_vinop(inode));
> > -             return 0;
> > +             /* The synthetic snapdir has the real directory's ino. */
> > +             parent =3D ceph_lookup_inode(inode->i_sb, ceph_ino(inode)=
);
> > +             if (IS_ERR(parent))
> > +                     return PTR_ERR(parent);
> > +             err =3D ceph_do_getattr(parent, mask, true);
> > +             iput(parent);
> > +             return err;
> >       }
> > +     if (ceph_in_snap(inode) && !ceph_snapshot_has_path(inode))
> > +             return ceph_snapshot_lookupino(inode, locked_folio, mask)=
;
> > +
> > +     /*
> > +      * Cached caps would satisfy getattr after the MDS has revoked
> > +      * access, and a short walk has no ancestor to consult. Ask the
> > +      * MDS so a lost quarantine-disable can clear the mark, and so
> > +      * an uncached parent chain is not treated as clear. Immutable sn=
apshot
> > +      * caps cannot receive revocations and always require an MDS chec=
k.
> > +      */
> > +     if (ceph_in_snap(inode) ||
> > +         ceph_inode_quarantine_state(inode) !=3D CEPH_Q_CLEAR)
> > +             force =3D true;
> >
> >       boutc(cl, "inode %p %llx.%llx mask %s mode 0%o\n", inode,
> >             ceph_vinop(inode), ceph_cap_string(mask), inode->i_mode);
> >       if (!force && ceph_caps_issued_mask_metric(ceph_inode(inode), mas=
k, 1))
> >                       return 0;
> >
> > +     qepoch =3D (u64)atomic64_read_acquire(&mdsc->quarantine_epoch);
> >       mode =3D ceph_try_to_choose_auth_mds(inode, mask);
> >       req =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR, mode)=
;
> >       if (IS_ERR(req))
> > @@ -3606,6 +3910,15 @@ int __ceph_do_getattr(struct inode *inode, struc=
t folio *locked_folio,
> >       req->r_args.getattr.mask =3D cpu_to_le32(mask);
> >       req->r_locked_folio =3D locked_folio;
> >       err =3D ceph_mdsc_do_request(mdsc, NULL, req);
> > +     if (ceph_in_snap(inode)) {
> > +             if (err =3D=3D -EINVAL || err =3D=3D -ESTALE ||
> > +                 (!err && ceph_snapshot_reply_error(inode, req, mask))=
) {
> > +                     ceph_mdsc_put_request(req);
> > +                     return ceph_snapshot_lookupino(inode, locked_foli=
o, mask);
> > +             }
> > +     }
> > +     if (!err && !ceph_in_snap(inode))
> > +             ceph_quarantine_remember_clear(inode, qepoch, req->r_cred=
);
> >       if (locked_folio && err =3D=3D 0) {
> >               u64 inline_version =3D req->r_reply_info.targeti.inline_v=
ersion;
> >               if (inline_version =3D=3D 0) {
> > @@ -3751,8 +4064,14 @@ int ceph_getattr(struct mnt_idmap *idmap, const =
struct path *path,
> >               return -ESTALE;
> >       }
> >
> > -     /* Skip the getattr altogether if we're asked not to sync */
> > -     if ((flags & AT_STATX_SYNC_TYPE) !=3D AT_STATX_DONT_SYNC) {
> > +     /*
> > +      * AT_STATX_DONT_SYNC would return the cached attrs. A
> > +      * quarantined inode, or one whose parents are not cached,
> > +      * still has to ask the MDS. Snapshot caps cannot receive revocat=
ions.
> > +      */
> > +     if (ceph_in_snap(inode) ||
> > +         ceph_inode_quarantine_state(inode) !=3D CEPH_Q_CLEAR ||
> > +         (flags & AT_STATX_SYNC_TYPE) !=3D AT_STATX_DONT_SYNC) {
> >               err =3D ceph_do_getattr(inode,
> >                               statx_to_caps(request_mask, inode->i_mode=
),
> >                               flags & AT_STATX_FORCE_SYNC);
> > diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> > index 12cb50e0a166..d152cad10c23 100644
> > --- a/fs/ceph/ioctl.c
> > +++ b/fs/ceph/ioctl.c
> > @@ -201,6 +201,10 @@ static long ceph_ioctl_get_dataloc(struct file *fi=
le, void __user *arg)
> >       if (copy_from_user(&dl, arg, sizeof(dl)))
> >               return -EFAULT;
> >
> > +     r =3D ceph_do_getattr(inode, CEPH_STAT_CAP_LAYOUT, false);
> > +     if (r)
> > +             return r;
> > +
> >       down_read(&osdc->lock);
> >       ceph_calc_file_object_mapping(&ci->i_layout, dl.file_offset, 1,
> >                                     &dl.object_no, &dl.object_offset, &=
xlen);
> > @@ -401,12 +405,18 @@ long ceph_ioctl(struct file *file, unsigned int c=
md, unsigned long arg)
> >
> >       case FS_IOC_GET_ENCRYPTION_POLICY:
> >               ret =3D vet_mds_for_fscrypt(file);
> > +             if (ret)
> > +                     return ret;
> > +             ret =3D ceph_quarantine_revalidate(inode);
> >               if (ret)
> >                       return ret;
> >               return fscrypt_ioctl_get_policy(file, (void __user *)arg)=
;
> >
> >       case FS_IOC_GET_ENCRYPTION_POLICY_EX:
> >               ret =3D vet_mds_for_fscrypt(file);
> > +             if (ret)
> > +                     return ret;
> > +             ret =3D ceph_quarantine_revalidate(inode);
> >               if (ret)
> >                       return ret;
> >               return fscrypt_ioctl_get_policy_ex(file, (void __user *)a=
rg);
> > @@ -429,6 +439,9 @@ long ceph_ioctl(struct file *file, unsigned int cmd=
, unsigned long arg)
> >
> >       case FS_IOC_GET_ENCRYPTION_NONCE:
> >               ret =3D vet_mds_for_fscrypt(file);
> > +             if (ret)
> > +                     return ret;
> > +             ret =3D ceph_quarantine_revalidate(inode);
> >               if (ret)
> >                       return ret;
> >               return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index 816f5f2d32cc..67d4c6279e00 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -39,7 +39,14 @@ enum ceph_feature_type {
> >       CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,
> >       CEPHFS_FEATURE_SUBVOLUME_METRICS,
> >
> > -     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_SUBVOLUME_METRICS,
> > +     /*
> > +      * Bit 23 is CEPHFS_FEATURE_BLOCKDIFF on the MDS and is not
> > +      * advertised here. Bit 24 is subvolume quarantine; it must stay
> > +      * aligned with the userspace client.
> > +      */
> > +     CEPHFS_FEATURE_QUARANTINE =3D 24,
> > +
> > +     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_QUARANTINE,
> >  };
> >
> >  #define CEPHFS_FEATURES_CLIENT_SUPPORTED {   \
> > @@ -57,6 +64,7 @@ enum ceph_feature_type {
> >       CEPHFS_FEATURE_HAS_OWNER_UIDGID,        \
> >       CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,     \
> >       CEPHFS_FEATURE_SUBVOLUME_METRICS,       \
> > +     CEPHFS_FEATURE_QUARANTINE,              \
> >  }
> >
> >  /*
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index 0264bd9d705f..540f31121f84 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -1394,8 +1394,6 @@ int ceph_set_acl(struct mnt_idmap *idmap,
> >                struct dentry *dentry, struct posix_acl *acl, int type);
> >  int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
> >                      struct ceph_acl_sec_ctx *as_ctx);
> > -void ceph_init_inode_acls(struct inode *inode,
> > -                       struct ceph_acl_sec_ctx *as_ctx);
> >
> >  static inline void ceph_forget_all_cached_acls(struct inode *inode)
> >  {
> > @@ -1412,11 +1410,6 @@ static inline int ceph_pre_init_acls(struct inod=
e *dir, umode_t *mode,
> >  {
> >       return 0;
> >  }
> > -static inline void ceph_init_inode_acls(struct inode *inode,
> > -                                     struct ceph_acl_sec_ctx *as_ctx)
> > -{
> > -}
> > -
> >  static inline void ceph_forget_all_cached_acls(struct inode *inode)
> >  {
> >  }
> > @@ -1578,7 +1571,7 @@ static inline bool ceph_has_inline_data(const str=
uct ceph_inode_info *ci)
> >  /* file.c */
> >  extern const struct file_operations ceph_file_fops;
> >
> > -extern int ceph_renew_caps(struct inode *inode, int fmode);
> > +int ceph_renew_caps(struct inode *inode, int fmode, bool force);
> >  extern int ceph_open(struct inode *inode, struct file *file);
> >  extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
> >                           struct file *file, unsigned flags, umode_t mo=
de);
> > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > index 4cba6e7bffd3..7fd307fcbe5a 100644
> > --- a/fs/ceph/xattr.c
> > +++ b/fs/ceph/xattr.c
> > @@ -997,6 +997,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const =
char *name, void *value,
> >       struct ceph_vxattr *vxattr;
> >       int req_mask;
> >       ssize_t err;
> > +     bool ask_mds =3D false;
> >
> >       if (strncmp(name, XATTR_CEPH_PREFIX, XATTR_CEPH_PREFIX_LEN))
> >               goto handle_non_vxattrs;
> > @@ -1034,7 +1035,19 @@ ssize_t __ceph_getxattr(struct inode *inode, con=
st char *name, void *value,
> >             ceph_vinop(inode), name, ci->i_xattrs.version,
> >             ci->i_xattrs.index_version);
> >
> > -     if (ci->i_xattrs.version =3D=3D 0 ||
> > +     /*
> > +      * A shared cap would answer from the cache. The state check may
> > +      * schedule, so drop i_ceph_lock first. A reply reading the blob
> > +      * it just installed must still use that cache.
> > +      */
> > +     if (!ceph_current_fill_trace_request()) {
> > +             spin_unlock(&ci->i_ceph_lock);
> > +             ask_mds =3D ceph_in_snap(inode) ||
> > +                       ceph_inode_quarantine_state(inode) !=3D CEPH_Q_=
CLEAR;
> > +             spin_lock(&ci->i_ceph_lock);
> > +     }
> > +
> > +     if (ask_mds || ci->i_xattrs.version =3D=3D 0 ||
> >           !((req_mask & CEPH_CAP_XATTR_SHARED) ||
> >             __ceph_caps_issued_mask_metric(ci, CEPH_CAP_XATTR_SHARED, 1=
))) {
> >               spin_unlock(&ci->i_ceph_lock);
> > @@ -1089,6 +1102,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, cha=
r *names, size_t size)
> >       struct ceph_client *cl =3D ceph_inode_to_client(inode);
> >       struct ceph_inode_info *ci =3D ceph_inode(inode);
> >       bool len_only =3D (size =3D=3D 0);
> > +     bool ask_mds =3D false;
> >       u32 namelen;
> >       int err;
> >       struct ceph_journal_info __ji;
> > @@ -1100,7 +1114,15 @@ ssize_t ceph_listxattr(struct dentry *dentry, ch=
ar *names, size_t size)
> >             ceph_vinop(inode), ci->i_xattrs.version,
> >             ci->i_xattrs.index_version);
> >
> > -     if (ci->i_xattrs.version =3D=3D 0 ||
> > +     /* Same as __ceph_getxattr(): do not serve a shared cap hit. */
> > +     if (!ceph_current_fill_trace_request()) {
> > +             spin_unlock(&ci->i_ceph_lock);
> > +             ask_mds =3D ceph_in_snap(inode) ||
> > +                       ceph_inode_quarantine_state(inode) !=3D CEPH_Q_=
CLEAR;
> > +             spin_lock(&ci->i_ceph_lock);
> > +     }
> > +
> > +     if (ask_mds || ci->i_xattrs.version =3D=3D 0 ||
> >           !__ceph_caps_issued_mask_metric(ci, CEPH_CAP_XATTR_SHARED, 1)=
) {
> >               spin_unlock(&ci->i_ceph_lock);
> >               err =3D ceph_do_getattr(inode, CEPH_STAT_CAP_XATTR, true)=
;
> > @@ -1222,6 +1244,7 @@ int __ceph_setxattr(struct inode *inode, const ch=
ar *name,
> >       int required_blob_size;
> >       bool check_realm =3D false;
> >       bool lock_snap_rwsem =3D false;
> > +     bool checked_quarantine =3D false;
> >
> >       if (ceph_in_snap(inode))
> >               return -EROFS;
> > @@ -1319,6 +1342,33 @@ int __ceph_setxattr(struct inode *inode, const c=
har *name,
> >               goto retry;
> >       }
> >
> > +     /*
> > +      * XATTR_EXCL applies the new blob with no MDS round trip.
> > +      * The state check may schedule, so drop i_ceph_lock first.
> > +      */
> > +     if (!checked_quarantine) {
> > +             enum ceph_qstate qstate;
> > +
> > +             spin_unlock(&ci->i_ceph_lock);
> > +             qstate =3D ceph_inode_quarantine_write_state(inode);
> > +             if (qstate =3D=3D CEPH_Q_UNDER &&
> > +                 ceph_inode_quarantine_direct(inode)) {
> > +                     ceph_buffer_put(old_blob);
> > +                     if (lock_snap_rwsem)
> > +                             up_read(&mdsc->snap_rwsem);
> > +                     err =3D -EACCES;
> > +                     goto out;
> > +             }
> > +             if (qstate !=3D CEPH_Q_CLEAR) {
> > +                     ceph_buffer_put(old_blob);
> > +                     old_blob =3D NULL;
> > +                     goto do_sync_unlocked;
> > +             }
> > +             checked_quarantine =3D true;
> > +             spin_lock(&ci->i_ceph_lock);
> > +             goto retry;
> > +     }
> > +
> >       err =3D __set_xattr(ci, newname, name_len, newval, val_len,
> >                         flags, value ? 1 : -1, &xattr);
> >
> > --
> > 2.34.1
> >
> >
>

