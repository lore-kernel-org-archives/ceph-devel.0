From: "Yan, Zheng" <zheng.z.yan@linux.intel.com>
Subject: Re: Kernel crashes with RBD
Date: Wed, 6 Jun 2012 15:32:22 +0800
Message-ID: <CAAM7YAk-MubvemCX8=zxE+gfTh3+S9-sGWCwXM0r+gkkgtJ8=Q@mail.gmail.com>
References: <4F860619.5040802@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46502 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab2FFHcX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 03:32:23 -0400
Received: by obbtb18 with SMTP id tb18so9921940obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 00:32:22 -0700 (PDT)
In-Reply-To: <4F860619.5040802@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I think I tracked this bug down, the Oops is due to 'msg->bio_iter =3D=3D=
 NULL'.

---
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index f0993af..ac16f13 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -549,6 +549,10 @@ static void prepare_write_message(struct
ceph_connection *con)
 	}

 	m =3D list_first_entry(&con->out_queue, struct ceph_msg, list_head);
+#ifdef CONFIG_BLOCK
+	if (m->bio && m->bio_iter)
+		m->bio_iter =3D NULL;
+#endif
 	con->out_msg =3D m;

 	/* put message on sent list */


On Thu, Apr 12, 2012 at 6:30 AM, Danny Kukawka <danny.kukawka@bisect.de=
> wrote:
> Hi,
>
> we are currently testing CEPH with RBD on a cluster with 1GBit and
> 10Gbit interfaces. While we see no kernel crashes with RBD if the
> cluster runs on the 1GBit interfaces, we see very frequent kernel
> crashes with the 10Gbit network while running tests with e.g. fio
> against the RBDs.
>
> I've tested it with kernel v3.0 and also 3.3.0 (with the patches from
> the 'for-linus' branch from ceph-client.git at git.kernel.org).
>
> With more client machines running tests the crashes occur even much
> faster. The issue is fully reproducible here.
>
> Has anyone seen similar problems? See the backtrace below.
>
> Regards
>
> Danny
>
> PID: 10902 =A0TASK: ffff88032a9a2080 =A0CPU: 0 =A0 COMMAND: "kworker/=
0:0"
> =A0#0 [ffff8803235fd950] machine_kexec at ffffffff810265ee
> =A0#1 [ffff8803235fd9a0] crash_kexec at ffffffff810a3bda
> =A0#2 [ffff8803235fda70] oops_end at ffffffff81444688
> =A0#3 [ffff8803235fda90] __bad_area_nosemaphore at ffffffff81032a35
> =A0#4 [ffff8803235fdb50] do_page_fault at ffffffff81446d3e
> =A0#5 [ffff8803235fdc50] page_fault at ffffffff81443865
> =A0 =A0[exception RIP: read_partial_message+816]
> =A0 =A0RIP: ffffffffa041e500 =A0RSP: ffff8803235fdd00 =A0RFLAGS: 0001=
0246
> =A0 =A0RAX: 0000000000000000 =A0RBX: 00000000000009d7 =A0RCX: 0000000=
000008000
> =A0 =A0RDX: 0000000000000000 =A0RSI: 00000000000009d7 =A0RDI: fffffff=
f813c8d78
> =A0 =A0RBP: ffff880328827030 =A0 R8: 00000000000009d7 =A0 R9: 0000000=
000004000
> =A0 =A0R10: 0000000000000000 =A0R11: ffffffff81205800 =A0R12: 0000000=
000000000
> =A0 =A0R13: 0000000000000069 =A0R14: ffff88032a9bc780 =A0R15: 0000000=
000000000
> =A0 =A0ORIG_RAX: ffffffffffffffff =A0CS: 0010 =A0SS: 0018
> =A0#6 [ffff8803235fdd38] thread_return at ffffffff81440e82
> =A0#7 [ffff8803235fdd78] try_read at ffffffffa041ed58 [libceph]
> =A0#8 [ffff8803235fddf8] con_work at ffffffffa041fb2e [libceph]
> =A0#9 [ffff8803235fde28] process_one_work at ffffffff8107487c
> #10 [ffff8803235fde78] worker_thread at ffffffff8107740a
> #11 [ffff8803235fdee8] kthread at ffffffff8107b736
> #12 [ffff8803235fdf48] kernel_thread_helper at ffffffff8144c144
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
