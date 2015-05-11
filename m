From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: trimming rbd image does not reclaim free space
Date: Mon, 11 May 2015 14:47:26 +0300
Message-ID: <CAOi1vP82mq27JMKm_ETwE0pzw5fG1x+tSnSx1904Fmc-hHhOtg@mail.gmail.com>
References: <927CE7A8-9A06-4CC3-A687-87E153070635@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35735 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbEKLr2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 07:47:28 -0400
Received: by widdi4 with SMTP id di4so101917519wid.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 04:47:26 -0700 (PDT)
In-Reply-To: <927CE7A8-9A06-4CC3-A687-87E153070635@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Edgaras_Luko=C5=A1evi=C4=8Dius?= <edgaras.lukosevicius@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 11, 2015 at 2:26 PM, Edgaras Luko=C5=A1evi=C4=8Dius
<edgaras.lukosevicius@gmail.com> wrote:
> Hello,
>
> I have ceph pool (size=3D2) and three RBD images (2TB each) and I hav=
e noticed, that deleting data does not reclaim data on ceph.
> What I have done is mount RBD device as a loopback device loop0, moun=
ted it to a filesystem, ran =E2=80=9Cfstrim=E2=80=9D and got response:

What do you mean by that?  Can you elaborate - paste the commands you
used?

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
