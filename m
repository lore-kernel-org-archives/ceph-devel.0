From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] use int64_t for return values from rbd
 instead of int
Date: Thu, 22 Nov 2012 08:40:15 +0000
Message-ID: <CAFEAcA86AomWmobTObpw80rMNWM30JzAKqHZXWxmB48+GU3VYQ@mail.gmail.com>
References: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
	<50AD096E.9080002@weilnetz.de>
	<CAFEAcA-cAx88UZRQjHT7uk_oj8P+tXBJ+hb9v0N1Wym8FUMkHQ@mail.gmail.com>
	<50ADE115.4060707@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <50ADE115.4060707@profihost.ag>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, pve-devel@pve.proxmox.com, pbonzini@redhat.com, josh.durgin@inktank.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 22 November 2012 08:23, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Am 21.11.2012 23:32, schrieb Peter Maydell:
>> Looking at the librbd API (which is what the size and ret
>> values come from), it uses size_t and ssize_t for these.
>> So I think probably ssize_t is the right type for ret
>> (and size) in our structs here.
>
>
> This sounds reasonable but does ssize_t support negative values? For error
> values.

Yes, the first 's' in ssize_t means 'signed' and is the
difference between it and size_t.

-- PMM
