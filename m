From: Christian Brunner <chb@muc.de>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Mon, 24 May 2010 21:07:14 +0200
Message-ID: <AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com>
References: <20100519192222.GD61706@ncolin.muc.de>
	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
	 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>
	 <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>
	 <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>
	 <4BFA5D96.3030603@redhat.com>
	 <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>
	 <4BFA696D.2060606@redhat.com>
	 <lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp>
Sender: kvm-owner@vger.kernel.org
To: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
Cc: Avi Kivity <avi@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

2010/5/24 MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>:

>> However, I don't think nbd would be a good protocol. =A0My preferenc=
e
>> would be for a plugin API, or for a new local protocol that uses
>> splice() to avoid copies.
>>
>
> Both would be okay for Sheepdog. =A0I want to take a suitable approac=
h
> for qemu.

I think both should be possible:

- Using splice() we would need a daemon that is listening on a control
socket for
  requests from qemu-processes or admin commands. When a qemu-process
  wants to open an image it could call open_image("protocol:imagename")=
 on the
  controll socket and the daemon has to create a pipe to which the
image is mapped.
  (What I'm unsure about, are the security implications. Do we need som=
e kind of
  authentication for the sockets? What about sVirt?

- Building a plugin API seems a bit simpler to me, although I'm to
sure if I'd get the
  idea correctly:
  The block layer has already some kind of api (.bdrv_file_open, .bdrv_=
read). We
  could simply compile the block-drivers as shared objects and create a=
 method
  for loading the necessary modules at runtime.

Are you planing to use this for all block drivers?

Regards,
Christian
