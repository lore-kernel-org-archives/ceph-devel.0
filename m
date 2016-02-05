From: Samuel Just <sjust@redhat.com>
Subject: Re: rados and the next hammer release v0.94.6
Date: Fri, 5 Feb 2016 07:00:31 -0800
Message-ID: <CAN=+7FWNmcUbb=Bg=-F5sS2Zf1+4=47_n5rDzzxQ9YU7wEzpXA@mail.gmail.com>
References: <56B18A6D.7080000@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35786 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcBEPAc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 10:00:32 -0500
Received: by mail-yw0-f179.google.com with SMTP id g127so52825303ywf.2
        for <ceph-devel@vger.kernel.org>; Fri, 05 Feb 2016 07:00:32 -0800 (PST)
In-Reply-To: <56B18A6D.7080000@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Looks good to me!
-Sam

On Tue, Feb 2, 2016 at 9:04 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> The next hammer release as found at https://github.com/ceph/ceph/tree=
/hammer passed the rados suite (http://tracker.ceph.com/issues/13356#no=
te-55 and Sage also ran one although I don't have the reference) and th=
e upgrade suite (http://tracker.ceph.com/issues/13356#note-47). Do you =
think the hammer branch is ready for QE to start their own round of tes=
ting ?
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
