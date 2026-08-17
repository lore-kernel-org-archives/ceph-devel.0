Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B323429CEE
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973264; cv=pass; b=iVzJzqD/6I9DzdkXmGz6v+qYVBWGfbLVJ4RJ8K29tQZtW2OdFjIxU2A9WACKXOgAy+pSSacszCt0owJd2pmoLLyS9lgNKURtTyQHvdI2rEj70n36zHX55Cg8rjiLctGDe5yKId/QQdrxxCPbDy9ekIBPkh1QhcpqTTh8+oyWPis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973264; c=relaxed/simple;
	bh=1DlLwTW104OszDT/1II5RPaSBCaItMuBX3O6KwNsB5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBRKMng+UGTzLoPLlkTuo4TgtkGoQu27ynQaEMEyGva/gQwsUy3W17lFB1qw0uxEvs5sLd2OD6erIoWbtim/p3ErIQiTnjkTZrvmIVUt9xnXYz1/SGKhtMXrodERuf2Op+ULFg+85m82uYC5+Hu6377KvhD4nK8lu6zNvaHLN5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFjYFU1t; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFjYFU1t"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso5305282a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 06:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786973260; cv=none;
        d=google.com; s=arc-20260327;
        b=Oy9WCRhuPFJGg/jvyGralbKf4ls+nqnALYsywFfS+ZYbrsaXp9ZRKOmv5IPLciqOcb
         TLIuDDus+eygRuRAyoPGH5IxkqxsNljNvHoJwfHEm53KE16XIvjzfuoBta3Q7emtUrZA
         183WnljpYFCVc/PaMAtAeQiFv87GHQNeXPR/a9xouw02ctx5DxnWnuY1YkyEtItygA8o
         1xk14s1UtxYFdKAzg56eQZkIMg2Yyexvb4cIty5Y2vY89hECasVyEMMyeRqP5C7DSD66
         xAjkGuGLM4YViRMzgWhsGknibHKewdm6nXLSjk2ahUZd0iSO4Fop2pO7UhsjVaOeHo9p
         pvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5PImzGjw1as2Qy3XGkcxUdLAPTNoN5hAmeBUTq6U/L8=;
        fh=FqoUDrjl/5akdOOKBUx+sqlcmJKf07RbT9iVh6j2dlE=;
        b=mekO0JElRE6KsOJB5AE/Uh56GyraO1HdCA7SUZnkOKojFCwiSv3n4ZqwY77N7dhb6O
         v8bkF6qApWZpEaBljTSz/wjhHLQWSpifqYTfQGE+e2bfUWEbEVV0Jmt4chl8oBIjSBsX
         ZFUqsqd7pv2GCd5VrbNxo9VZfLh6+EJmDMJDAuRJotMc9PELEQxMYEfOvCKUoYKtuUaA
         b+VJwzM4FFVarwmsg4PWQRHEGmb2NOaJb4bYAPokc2ggrVceRqQWL9Mrde9bLz+qJfM4
         sTdE+X0YMDucrTX9hOqphb9dFg7FWyNeAl5AsijZM7uoUh3CsCvrrRR0+AhFA7kJMNlD
         PD7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786973260; x=1787578060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5PImzGjw1as2Qy3XGkcxUdLAPTNoN5hAmeBUTq6U/L8=;
        b=aFjYFU1tlLPMRER4pipHl3ANVxgkOpp+ndm/NLf7Pq83xOKblowW91NietJHufVnaU
         mG6fHdWFmqeqE7Za+MQqPL6w4geucj6kn1XHrsbXH9fB5A51lgvvXUgpWIP+3Pf/Kr/6
         E3yOuOXV2xWiDnVOHp+WQEOghMjyssS26hPeiD6oTng8zPUYOFghMQwJWe0lRL0POps+
         SuzQa+NquXQZJGM9fqIgYAOg6FkJKEnN6kYmTkEj7Mdz7+EuQF2GKfaT1P53L8FxYxdF
         9+WaDR8hgyKro9QERMbIB8mymp8IjIl17/FmueYmhk4/X5idZLePC/Umu/42+ULghIi/
         1Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786973260; x=1787578060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5PImzGjw1as2Qy3XGkcxUdLAPTNoN5hAmeBUTq6U/L8=;
        b=Y0oIsb1OfEk6iLLKBmJo4vhnRnCChwm2aIJFBA5z3BHOY7dWoSG5KkgBsTOvttrUR7
         baWJWevPubwyZFUSMQJlxzYeqgFfL7xjqthv6ekeyiRT3U/zClITkVJzYWRsSenquHSa
         sIdfdewPyeLuN1zQ6zEB3+xKRIW2c28QozQDMNu20BAHZipBVokDDQh2qvmEMf7nl7/S
         GxNaV+9N/c54A4lCIxOVDVTGZPyfchC8eETjjWQHlYOT9qyF3IcczimIO+dE1PlMfJzT
         byLhNsD0wV1QN1YP56jMpWHiYdFn522/A+yhI0lDHFCfNOo2QXaEKFmeS9OSJ3UzeBNf
         TkgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0fy6fQ+FHYoSwSy5sTyJZ+02KUJAW+fM7jpW/UYCBAoP3jJA0mGOArp7EqmxSN9Oxd8wUkUG6Easj@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGZX2HOk7DoLai8Tjm2nzbGWwjVzlI8hDhbIMrzxWnFIrhXg4
	xrrJGKW4U+wkCViLLBuAFITFiCHGSakDmc/bvR200eQ8MtaklBdYlS5RFvNny8dqzpoK2MyTZC3
	PxOZn39ssBxLC50CSeb5jR9GaVcXq2bM=
X-Gm-Gg: AR+sD119f8bwJ1wrfbUvtOMFs1unv2nfXqlegpm8ZWpE3QNgNsw5X8V+dszhtNJXVFl
	bPoboivl1LYEJrrg+YAw8nH6kwADyWUv9vGi+wFgksU2TB6Jt77qfGaqENtF60Q60r5c+rrdQYY
	LTjs16nPwzzfB7jbhr14cri3hjLenZ819TMy6ywPx5WwsRo89QJ/701XwV8LjNcDCsXyTPRXsYW
	dfzBriyLiPfykMDaAsrNcJI0p6bkDM/92szE5d67oQp+g1oIcnfQ6TDfPTujIIaz3OdnSzdT8k+
	cXprnRA2Q97J55JNOduo/vxU/f3CYqV2nZ8R8pB8YbsfzA==
X-Received: by 2002:a17:907:5c2:b0:c16:1227:e3d8 with SMTP id
 a640c23a62f3a-c2129c1bd00mr1250866166b.13.1786973259962; Mon, 17 Aug 2026
 06:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-4-neilb@ownmail.net>
 <CAJfpegs-k3skRGiwZvQLzD7OrAK4KL8zwmpmJKyjRHSQ-rqX+Q@mail.gmail.com>
 <178642552869.2852630.11443303758249822243@noble.neil.brown.name>
 <178675372176.2852630.1305553887009521382@noble.neil.brown.name> <oh2lg2agqxwqopecacq6sfdnky5faxidwsybkvbwbq24r6tw6o@4swfog5ocwwb>
In-Reply-To: <oh2lg2agqxwqopecacq6sfdnky5faxidwsybkvbwbq24r6tw6o@4swfog5ocwwb>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Aug 2026 15:27:28 +0200
X-Gm-Features: AcwNN1XGT7C9D5visKW_eW7eV24-4iD41ayTDyPPniVL030x1LtgVNaa9P7WcV8
Message-ID: <CAOQ4uxgtKvKmPaK8rPAZDSwu0Hr9JAmqJi0a1VX_Rg7jDo8HrQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/12] fsnotify: don't hold a spin_lock across
 fsnotify_recalc_mask() calls.
To: Jan Kara <jack@suse.cz>
Cc: NeilBrown <neil@brown.name>, Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, 
	Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 1:03=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 15-08-26 10:28:41, NeilBrown wrote:
> > On Tue, 11 Aug 2026, NeilBrown wrote:
> > > On Tue, 11 Aug 2026, Miklos Szeredi wrote:
> > > > On Mon, 3 Aug 2026 at 03:39, NeilBrown <neilb@ownmail.net> wrote:
> > > >
> > > > > @@ -116,11 +117,15 @@ static int dnotify_handle_event(struct fsno=
tify_mark *inode_mark, u32 mask,
> > > > >                 else {
> > > > >                         *prev =3D dn->dn_next;
> > > > >                         kmem_cache_free(dnotify_struct_cache, dn)=
;
> > > > > -                       dnotify_recalc_inode_mask(inode_mark);
> > > > > +                       need_recalc =3D true;
> > > > >                 }
> > > > >         }
> > > > >
> > > > > +       if (need_recalc)
> > > > > +               need_recalc =3D dnotify_recalc_inode_mask(inode_m=
ark);
> > > > >         spin_unlock(&inode_mark->lock);
> > > > > +       if (need_recalc)
> > > > > +               fsnotify_recalc_mask(inode_mark->connector);
> > > >
> > > > Is the fsnotify_group_lock() held in this case?   I don't see it.
> > >
> > > It isn't held.  Doesn't it need to be...
> > > It seems to protect marks, so maybe it does.
> > >
> > > srcu seems to be used to protect this section, so maybe we can rely o=
n
> > > that.
> >
> > I dug into this some more, and we do rely on srcu, but don't need the
> > extra code below.
> > inode_mark->lock doesn't protect inode_mark->connector, so moving the
> > dereference out of the lock has no effect.
> > srcu_read_lock is taken before we get the ref to the mark, so the mark
> > and the connector cannot disappear underneath us.
> > A race could result in inode_mark->connector reading as NULL, but
> > fsnotify_recalc_mask() checks for NULL, so there is no risk for harm.
> >
> > Thanks for encouraging me to dig into this.
>
> Sorry for not replying earlier but I was on vacation. The lifetime rules
> around marks & connectors are subtle so we have to be really careful and
> dnotify with its single shot marks is peculiar which makes things even
> harder. fsnotify_recalc_mask() has a comment about locking in front of it=
:
>
> /*
>  * Calculate mask of events for a list of marks. The caller must make sur=
e
>  * connector and connector->obj cannot disappear under us.  Callers achie=
ve
>  * this by holding a mark->lock or mark->group->mark_mutex for a mark on =
this
>  * list.
>  */
>
> and you very obviously start violating these rules with your changes. Now=
 I
> admit I've forgotten all the details why I did it like this so let me
> reconstruct it :).
>
> Connector stays alive as long as there's any mark in its list. Both marks
> and connectors are protected by the srcu. Mark also has
> FSNOTIFY_MARK_FLAG_ATTACHED flag which is set iff the connector->obj is
> pointing to valid inode/mount/... FSNOTIFY_MARK_FLAG_ATTACHED changes onl=
y
> under mark_mutex so that's why mark_mutex is stabilizing the connector (a=
nd
> also connector->obj). This is what is used by most places calling
> fsnotify_recalc_mask(). But dnotify needs to mess with notification mark
> mask from event handling and there we cannot take mark_mutex due to lock
> ordering constraints. That's where the mark->lock rule comes into play
> because mark->lock also needs to be acquired to clear
> FSNOTIFY_MARK_FLAG_ATTACHED. That being said this dnotify use of
> fsnotify_recalc_mask() still looks somewhat racy because
> dnotify_handle_event() can get called after FSNOTIFY_MARK_FLAG_ATTACHED i=
s
> cleared.
>
> Anyway if you move fsnotify_recalc_mask() call outside of mark->lock, you
> seem to make the race with dnotify clearing the mark from
> fcntl_dirnotify() easier to hit. Now in the notification path the inode
> itself is guaranteed to stay alive and the rest is protected by the SRCU =
so
> there's no direct UAF. But fsnotify_recalc_mask() simply isn't prepared f=
or
> the connector changing under it due to object getting detached and so we
> could end up doing weird things like NULL ptr derefs or similar stuff.
>
> So this call to fsnotify_recalc_mask() from dnotify needs a more careful
> handling. Which is sad because I doubt anybody still uses dnotify...

Maybe this is the way out.

dnotify_recalc_inode_mask() can only remove bits from i_fsnotify_mask,
so it is an optimization.

If we just remove fsnotify_recalc_mask() call from
dnotify_recalc_inode_mask(), then i_fsnotify_mask will be updated when
dnotify_mask gets removed eventually.

If nobody uses dnotify, noone is likely to notice the loss of the optimizat=
ion.

Thanks,
Amir.
