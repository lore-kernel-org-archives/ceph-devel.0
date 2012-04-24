From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: NFS over Ceph
Date: Mon, 23 Apr 2012 17:12:22 -0700
Message-ID: <CAORUGqDeEj+HBLMq4y+zezbZEaG8nVCgWOhjFY1Cfg08gubcww@mail.gmail.com>
References: <CADxhoDTMQMrNBYE8PykjB4UCkCBmyXcUsKxnaXmfyYNbfr9-7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64335 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab2DXAMo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Apr 2012 20:12:44 -0400
Received: by vbbff1 with SMTP id ff1so88066vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 Apr 2012 17:12:44 -0700 (PDT)
In-Reply-To: <CADxhoDTMQMrNBYE8PykjB4UCkCBmyXcUsKxnaXmfyYNbfr9-7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Calvin Morrow <calvin.morrow@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Apr 23, 2012 at 16:50, Calvin Morrow <calvin.morrow@gmail.com> =
wrote:
> Should I be trying this a different way? =C2=A0NFS export of a filesy=
stem
> (ext4 / xfs) on RBD? =C2=A0Other options? =C2=A0Also, does the fileha=
ndle
> limitation specified above apply to more than NFS (such as a KVM imag=
e
> using a file on a ceph mount for storage backing)?

I can't really help you with most of your email right now, but I
wanted to add a tidbit that wasn't mentioned in your message:

There's been work to export a Ceph filesystem, without mounting &
re-exporting, by using nfs-ganesha and either a custom libceph mapper,
or the FUSE mapping. Ceph has a FUSE daemon, and ganesha claims to be
able to use just about any FUSE filesystem work woth it.. so if you're
actually investing R&D into this, that way might be worth exploring.

http://sourceforge.net/apps/trac/nfs-ganesha/

Perhaps someone else can fill in their experiences with that line of st=
udy.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
