From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [PATCHv4] rbd block driver fix race between aio
 completition and aio cancel
Date: Thu, 29 Nov 2012 22:38:51 +0100
Message-ID: <50B7D5EB.5030105@profihost.ag>
References: <249699163.16251603.1354202609373.JavaMail.root@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <249699163.16251603.1354202609373.JavaMail.root@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: stefanha@gmail.com, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, josh durgin <josh.durgin@inktank.com>
List-Id: ceph-devel.vger.kernel.org

Hi Paolo,

Am 29.11.2012 16:23, schrieb Paolo Bonzini:
>> +    qemu_vfree(acb->bounce);
>
> This vfree is not needed, since the BH will run and do the free.

new patch v5 sent.

Greets,
Stefan
