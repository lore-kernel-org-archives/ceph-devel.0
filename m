From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] hw/9pfs: Add CephFS support in VirtFS
Date: Sun, 17 Apr 2016 00:23:09 +0530
Message-ID: <87potp9yi2.fsf@skywalker.in.ibm.com>
References: <1457971368-1335-1-git-send-email-scaleqiao@gmail.com>
	<20160407175030.5b6f2edb@bahia.huguette.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20160407175030.5b6f2edb@bahia.huguette.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, Jevon Qiao <scaleqiao@gmail.com>
Cc: haomaiwang@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, sage@newdream.net, ceph-devel@vger.kernel.org, gfarnum@redhat.com
List-Id: ceph-devel.vger.kernel.org

Greg Kurz <gkurz@linux.vnet.ibm.com> writes:

> On Tue, 15 Mar 2016 00:02:48 +0800
> Jevon Qiao <scaleqiao@gmail.com> wrote:
>
>> Ceph as a promising unified distributed storage system is widely used in the
>> world of OpenStack. OpenStack users deploying Ceph for block (Cinder) and
>> object (S3/Swift) are unsurprisingly looking at Manila and CephFS to round out
>> a unified storage solution. Since the typical hypervisor people are using is
>> Qemu/KVM, it is necessary to provide a high performance, easy to use, file
>> system service in it. VirtFS aims to offers paravirtualized system services and
>> simple passthrough for directories from host to guest, which currently only
>> support local file system, this patch wants to add CephFS support in VirtFS.
>> 
>> Signed-off-by: Jevon Qiao <scaleqiao@gmail.com>
>> ---
>
> Jevon,
>
> There's still work to be done on this patch.
>
> One general remark is that there are far too many traces: it obfuscates the code
> and does not bring much benefit in my opinion. If you look at the other fsdev
> drivers, you see they don't do traces at all !
>
> Also, I've found several errors where the code simply cannot work... please run
> a file/io oriented testsuite in the guest to check all the fsdev operations are
> working as expected... maybe some tests from LTP ?

Also use this http://tuxera.com/sw/qa/pjd-fstest-20090130-RC.tgz 

-aneesh
