From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] use int64_t for return values from rbd
 instead of int
Date: Wed, 21 Nov 2012 22:32:49 +0000
Message-ID: <CAFEAcA-cAx88UZRQjHT7uk_oj8P+tXBJ+hb9v0N1Wym8FUMkHQ@mail.gmail.com>
References: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
	<50AD096E.9080002@weilnetz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <50AD096E.9080002@weilnetz.de>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Stefan Weil <sw@weilnetz.de>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, pve-devel@pve.proxmox.com, pbonzini@redhat.com, josh.durgin@inktank.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 21 November 2012 17:03, Stefan Weil <sw@weilnetz.de> wrote:
> Why do you use int64_t instead of off_t?
> If the value is related to file sizes, off_t would be a good choice.

Looking at the librbd API (which is what the size and ret
values come from), it uses size_t and ssize_t for these.
So I think probably ssize_t is the right type for ret
(and size) in our structs here.

-- PMM
