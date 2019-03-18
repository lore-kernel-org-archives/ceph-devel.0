From: George Spelvin <lkml@sdf.org>
Subject: [RFC PATCH v1 11/50] Treewide: Extirpate "prandom_u32() % range"
Date: Mon, 18 Mar 2019 01:46:20 -0400
Message-ID: <202003281643.02SGhAN9009531@sdf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, lkml@sdf.org
Cc: Jeff Layton <jlayton@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>, Vignesh Raghavendra <vigneshr@ti.com>, Peter Zijlstra <peterz@infradead.org>, linux-wireless@vger.kernel.org, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Dave Hansen <dave.hansen@linux.intel.com>, Antonio Quartulli <a@unstable.cc>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Wright Feng <wright.feng@cypress.com>, linux-mm@kvack.org, linux-sctp@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, QLogic-Storage-Upstream@cavium.com, Atul Gupta <atul.gupta@chelsio.com>, Sven Eckelmann <sven@narfation.org>, Marek Lindner <mareklindner@neomailbox.ch>, Steffen Klassert <steffen.klassert@secunet.com>, Stephen Hemminger <stephen@networkplumber.org>, Simon Wunderlich <sw@simonwunderlich.d>
List-Id: ceph-devel.vger.kernel.org

% is fast to type but slow to compute.  Even if the range is
a compile-time constant, the code is two multiplications (one by a
reciprocal approximation, then a second to compute the modulus).

prandom_u32_max() is one multiply, so always smaller and faster.

This patch is all the simple cases; ones requiring a bit of thought
are separated out.

If the range is a power of 2, both variants optimize to one cheap
instruction, so conversion is optional.  In general, I've converted
when the range is a #define which is not immediately obvious is a
power of 2 (e.g. ROLLOVER_HLEN in net/packet/af_packet.c), but not
when it's a manifest constant (e.g. crypto/testmgr.c).

The one time the caller needs to optimize specially
is if range is a variable power of 2.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com> (maintainer:X86 MM)
Cc: Andy Lutomirski <luto@kernel.org> (maintainer:X86 MM)
Cc: Peter Zijlstra <peterz@infradead.org> (maintainer:X86 MM)
Cc: Herbert Xu <herbert@gondor.apana.org.au> (maintainer:CRYPTO API)
Cc: "David S. Miller" <davem@davemloft.net> (maintainer:CRYPTO API)
Cc: Atul Gupta <atul.gupta@chelsio.com> (supporter:CXGB4 CRYPTO DRIVER (chcr))
Cc: linux-crypto@vger.kernel.org (open list:CRYPTO API)
Cc: Doug Ledford <dledford@redhat.com> (supporter:INFINIBAND SUBSYSTEM)
Cc: Jason Gunthorpe <jgg@ziepe.ca> (supporter:INFINIBAND SUBSYSTEM)
Cc: Potnuri Bharat Teja <bharat@chelsio.com> (supporter:CXGB4 IWARP RNIC DRIVER (IW_CXGB4))
Cc: linux-rdma@vger.kernel.org (open list:INFINIBAND SUBSYSTEM)
Cc: Ulf Hansson <ulf.hansson@linaro.org> (maintainer:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...)
Cc: linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...)
Cc: Miquel Raynal <miquel.raynal@bootlin.com> (maintainer:NAND FLASH SUBSYSTEM)
Cc: Richard Weinberger <richard@nod.at> (reviewer:NAND FLASH SUBSYSTEM)
Cc: David Woodhouse <dwmw2@infradead.org> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
Cc: Brian Norris <computersforpeace@gmail.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
Cc: Marek Vasut <marek.vasut@gmail.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
Cc: Vignesh Raghavendra <vigneshr@ti.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
Cc: Artem Bityutskiy <dedekind1@gmail.com> (supporter:UNSORTED BLOCK IMAGES (UBI))
Cc: linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Cc: netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
Cc: Arend van Spriel <arend.vanspriel@broadcom.com> (supporter:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER)
Cc: Franky Lin <franky.lin@broadcom.com> (supporter:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER)
Cc: Hante Meuleman <hante.meuleman@broadcom.com> (supporter:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER)
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com> (supporter:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER)
Cc: Wright Feng <wright.feng@cypress.com> (supporter:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER)
Cc: brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER)
Cc: brcm80211-dev-list@cypress.com (open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER)
Cc: Kalle Valo <kvalo@codeaurora.org> (maintainer:NETWORKING DRIVERS (WIRELESS))
Cc: Johannes Berg <johannes.berg@intel.com> (supporter:INTEL WIRELESS WIFI LINK (iwlwifi))
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com> (supporter:INTEL WIRELESS WIFI LINK (iwlwifi))
Cc: Luca Coelho <luciano.coelho@intel.com> (supporter:INTEL WIRELESS WIFI LINK (iwlwifi))
Cc: Intel Linux Wireless <linuxwifi@intel.com> (supporter:INTEL WIRELESS WIFI LINK (iwlwifi))
Cc: linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER)
Cc: Hannes Reinecke <hare@suse.de> (supporter:FCOE SUBSYSTEM (libfc, libfcoe, fcoe))
Cc: QLogic-Storage-Upstream@cavium.com (supporter:QLOGIC QL41xxx ISCSI DRIVER)
Cc: linux-scsi@vger.kernel.org (open list:FCOE SUBSYSTEM (libfc, libfcoe, fcoe))
Cc: Jeff Layton <jlayton@kernel.org> (supporter:CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH))
Cc: Sage Weil <sage@redhat.com> (supporter:CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH))
Cc: Ilya Dryomov <idryomov@gmail.com> (supporter:CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH))
Cc: ceph-devel@vger.kernel.org (open list:CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH))
Cc: Jan Kara <jack@suse.com> (maintainer:EXT2 FILE SYSTEM)
Cc: "Theodore Ts'o" <tytso@mit.edu> (maintainer:EXT4 FILE SYSTEM)
Cc: Andreas Dilger <adilger.kernel@dilger.ca> (maintainer:EXT4 FILE SYSTEM)
Cc: linux-ext4@vger.kernel.org (open list:EXT2 FILE SYSTEM)
Cc: Adrian Hunter <adrian.hunter@intel.com> (supporter:UBI FILE SYSTEM (UBIFS))
Cc: "Darrick J. Wong" <darrick.wong@oracle.com> (supporter:XFS FILESYSTEM)
Cc: linux-xfs@vger.kernel.org (supporter:XFS FILESYSTEM)
Cc: Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT)
Cc: linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Cc: Marek Lindner <mareklindner@neomailbox.ch> (maintainer:BATMAN ADVANCED)
Cc: Simon Wunderlich <sw@simonwunderlich.de> (maintainer:BATMAN ADVANCED)
Cc: Antonio Quartulli <a@unstable.cc> (maintainer:BATMAN ADVANCED)
Cc: Sven Eckelmann <sven@narfation.org> (maintainer:BATMAN ADVANCED)
Cc: b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED)
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> (maintainer:NETWORKING [IPv4/IPv6])
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org> (maintainer:NETWORKING [IPv4/IPv6])
Cc: Jamal Hadi Salim <jhs@mojatatu.com> (maintainer:TC subsystem)
Cc: Cong Wang <xiyou.wangcong@gmail.com> (maintainer:TC subsystem)
Cc: Jiri Pirko <jiri@resnulli.us> (maintainer:TC subsystem)
Cc: Stephen Hemminger <stephen@networkplumber.org> (maintainer:NETEM NETWORK EMULATOR)
Cc: netem@lists.linux-foundation.org (moderated list:NETEM NETWORK EMULATOR)
Cc: Vlad Yasevich <vyasevich@gmail.com> (maintainer:SCTP PROTOCOL)
Cc: Neil Horman <nhorman@tuxdriver.com> (maintainer:SCTP PROTOCOL,added_lines:17/168=10%)
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> (maintainer:SCTP PROTOCOL)
Cc: linux-sctp@vger.kernel.org (open list:SCTP PROTOCOL)
Cc: "J. Bruce Fields" <bfields@fieldses.org> (supporter:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS)
Cc: Chuck Lever <chuck.lever@oracle.com> (supporter:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS)
Cc: Trond Myklebust <trond.myklebust@hammerspace.com> (maintainer:NFS, SUNRPC, AND LOCKD CLIENTS)
Cc: Anna Schumaker <anna.schumaker@netapp.com> (maintainer:NFS, SUNRPC, AND LOCKD CLIENTS)
Cc: linux-nfs@vger.kernel.org (open list:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS)
Cc: Jon Maloy <jon.maloy@ericsson.com> (maintainer:TIPC NETWORK LAYER)
Cc: Ying Xue <ying.xue@windriver.com> (maintainer:TIPC NETWORK LAYER)
Cc: tipc-discussion@lists.sourceforge.net (open list:TIPC NETWORK LAYER)
Cc: Steffen Klassert <steffen.klassert@secunet.com> (maintainer:NETWORKING [IPSEC])
---
 arch/x86/mm/pageattr-test.c                   |  4 ++--
 crypto/testmgr.c                              | 16 +++++++--------
 drivers/crypto/chelsio/chtls/chtls_io.c       |  4 ++--
 drivers/infiniband/core/cma.c                 |  2 +-
 drivers/infiniband/hw/cxgb4/id_table.c        |  4 ++--
 drivers/mmc/core/core.c                       |  4 ++--
 drivers/mtd/nand/raw/nandsim.c                |  4 ++--
 drivers/mtd/tests/mtd_nandecctest.c           | 10 +++++-----
 drivers/mtd/tests/stresstest.c                | 15 +++-----------
 drivers/mtd/ubi/debug.c                       |  2 +-
 drivers/net/ethernet/broadcom/cnic.c          |  3 +--
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 drivers/scsi/qedi/qedi_main.c                 |  2 +-
 fs/ceph/inode.c                               |  2 +-
 fs/ceph/mdsmap.c                              |  2 +-
 fs/ext2/ialloc.c                              |  3 +--
 fs/ext4/super.c                               |  8 ++++----
 fs/ubifs/debug.c                              |  6 +++---
 fs/ubifs/lpt_commit.c                         | 12 +++++------
 fs/xfs/xfs_error.c                            |  2 +-
 lib/find_bit_benchmark.c                      |  4 ++--
 lib/sbitmap.c                                 |  7 ++++---
 lib/test_list_sort.c                          |  2 +-
 mm/swapfile.c                                 |  2 +-
 net/batman-adv/bat_iv_ogm.c                   |  2 +-
 net/batman-adv/bat_v_elp.c                    |  2 +-
 net/batman-adv/bat_v_ogm.c                    |  2 +-
 net/ceph/mon_client.c                         |  2 +-
 net/core/neighbour.c                          |  6 +++---
 net/core/pktgen.c                             | 20 +++++++++----------
 net/core/stream.c                             |  2 +-
 net/ipv4/igmp.c                               |  6 +++---
 net/ipv4/inet_connection_sock.c               |  2 +-
 net/ipv6/addrconf.c                           |  2 +-
 net/ipv6/mcast.c                              | 10 +++++-----
 net/packet/af_packet.c                        |  2 +-
 net/sched/act_gact.c                          |  2 +-
 net/sched/act_sample.c                        |  2 +-
 net/sched/sch_netem.c                         |  7 +++----
 net/sctp/socket.c                             |  2 +-
 net/sunrpc/xprtsock.c                         |  2 +-
 net/tipc/socket.c                             |  5 ++---
 net/xfrm/xfrm_state.c                         |  2 +-
 44 files changed, 96 insertions(+), 108 deletions(-)

diff --git a/arch/x86/mm/pageattr-test.c b/arch/x86/mm/pageattr-test.c
index facce271e8b93..d184def2c3d49 100644
--- a/arch/x86/mm/pageattr-test.c
+++ b/arch/x86/mm/pageattr-test.c
@@ -137,10 +137,10 @@ static int pageattr_test(void)
 	failed += print_split(&sa);
 
 	for (i = 0; i < NTEST; i++) {
-		unsigned long pfn = prandom_u32() % max_pfn_mapped;
+		unsigned long pfn = prandom_u32_max(max_pfn_mapped);
 
 		addr[i] = (unsigned long)__va(pfn << PAGE_SHIFT);
-		len[i] = prandom_u32() % NPAGES;
+		len[i] = prandom_u32_max(NPAGES);
 		len[i] = min_t(unsigned long, len[i], max_pfn_mapped - pfn - 1);
 
 		if (len[i] == 0)
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 2c96963b2e51e..e8f21f7348a48 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -745,7 +745,7 @@ static int build_cipher_test_sglists(struct cipher_test_sglists *tsgls,
 /* Generate a random length in range [0, max_len], but prefer smaller values */
 static unsigned int generate_random_length(unsigned int max_len)
 {
-	unsigned int len = prandom_u32() % (max_len + 1);
+	unsigned int len = prandom_u32_max(max_len + 1);
 
 	switch (prandom_u32() % 4) {
 	case 0:
@@ -779,7 +779,7 @@ static void mutate_buffer(u8 *buf, size_t count)
 	if (prandom_u32() % 4 == 0) {
 		num_flips = min_t(size_t, 1 << (prandom_u32() % 8), count);
 		for (i = 0; i < num_flips; i++)
-			buf[prandom_u32() % count] ^= 0xff;
+			buf[prandom_u32_max(count)] ^= 0xff;
 	}
 }
 
@@ -840,7 +840,7 @@ static char *generate_random_sgl_divisions(struct test_sg_division *divs,
 		if (div == &divs[max_divs - 1] || prandom_u32() % 2 == 0)
 			this_len = remaining;
 		else
-			this_len = 1 + (prandom_u32() % remaining);
+			this_len = 1 + prandom_u32_max(remaining);
 		div->proportion_of_total = this_len;
 
 		if (prandom_u32() % 4 == 0)
@@ -962,7 +962,7 @@ static void generate_random_testvec_config(struct testvec_config *cfg,
 	}
 
 	if (prandom_u32() % 2 == 0) {
-		cfg->iv_offset = 1 + (prandom_u32() % MAX_ALGAPI_ALIGNMASK);
+		cfg->iv_offset = 1 + prandom_u32_max(MAX_ALGAPI_ALIGNMASK);
 		p += scnprintf(p, end - p, " iv_offset=%u", cfg->iv_offset);
 	}
 
@@ -1522,7 +1522,7 @@ static void generate_random_hash_testvec(struct shash_desc *desc,
 	if (maxkeysize) {
 		vec->ksize = maxkeysize;
 		if (prandom_u32() % 4 == 0)
-			vec->ksize = 1 + (prandom_u32() % maxkeysize);
+			vec->ksize = 1 + prandom_u32_max(maxkeysize);
 		generate_random_bytes((u8 *)vec->key, vec->ksize);
 
 		vec->setkey_error = crypto_shash_setkey(desc->tfm, vec->key,
@@ -2070,7 +2070,7 @@ static void generate_random_aead_testvec(struct aead_request *req,
 	/* Key: length in [0, maxkeysize], but usually choose maxkeysize */
 	vec->klen = maxkeysize;
 	if (prandom_u32() % 4 == 0)
-		vec->klen = prandom_u32() % (maxkeysize + 1);
+		vec->klen = prandom_u32_max(maxkeysize + 1);
 	generate_random_bytes((u8 *)vec->key, vec->klen);
 	vec->setkey_error = crypto_aead_setkey(tfm, vec->key, vec->klen);
 
@@ -2080,7 +2080,7 @@ static void generate_random_aead_testvec(struct aead_request *req,
 	/* Tag length: in [0, maxauthsize], but usually choose maxauthsize */
 	authsize = maxauthsize;
 	if (prandom_u32() % 4 == 0)
-		authsize = prandom_u32() % (maxauthsize + 1);
+		authsize = prandom_u32_max(maxauthsize + 1);
 	if (WARN_ON(authsize > maxdatasize))
 		authsize = maxdatasize;
 	maxdatasize -= authsize;
@@ -2659,7 +2659,7 @@ static void generate_random_cipher_testvec(struct skcipher_request *req,
 	/* Key: length in [0, maxkeysize], but usually choose maxkeysize */
 	vec->klen = maxkeysize;
 	if (prandom_u32() % 4 == 0)
-		vec->klen = prandom_u32() % (maxkeysize + 1);
+		vec->klen = prandom_u32_max(maxkeysize + 1);
 	generate_random_bytes((u8 *)vec->key, vec->klen);
 	vec->setkey_error = crypto_skcipher_setkey(tfm, vec->key, vec->klen);
 
diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
index 5cf9b021220b8..5427b61926bba 100644
--- a/drivers/crypto/chelsio/chtls/chtls_io.c
+++ b/drivers/crypto/chelsio/chtls/chtls_io.c
@@ -927,8 +927,8 @@ static int csk_wait_memory(struct chtls_dev *cdev,
 	current_timeo = *timeo_p;
 	noblock = (*timeo_p ? false : true);
 	if (csk_mem_free(cdev, sk)) {
-		current_timeo = (prandom_u32() % (HZ / 5)) + 2;
-		vm_wait = (prandom_u32() % (HZ / 5)) + 2;
+		current_timeo = prandom_u32_max(HZ / 5) + 2;
+		vm_wait = prandom_u32_max(HZ / 5) + 2;
 	}
 
 	add_wait_queue(sk_sleep(sk), &wait);
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 0b530646f1e51..a5874d2fac54e 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3366,7 +3366,7 @@ static int cma_alloc_any_port(enum rdma_ucm_port_space ps,
 
 	inet_get_local_port_range(net, &low, &high);
 	remaining = (high - low) + 1;
-	rover = prandom_u32() % remaining + low;
+	rover = prandom_u32_max(remaining) + low;
 retry:
 	if (last_used_port != rover) {
 		struct rdma_bind_list *bind_list;
diff --git a/drivers/infiniband/hw/cxgb4/id_table.c b/drivers/infiniband/hw/cxgb4/id_table.c
index 724d23297b355..edcae6af65d6c 100644
--- a/drivers/infiniband/hw/cxgb4/id_table.c
+++ b/drivers/infiniband/hw/cxgb4/id_table.c
@@ -54,7 +54,7 @@ u32 c4iw_id_alloc(struct c4iw_id_table *alloc)
 
 	if (obj < alloc->max) {
 		if (alloc->flags & C4IW_ID_TABLE_F_RANDOM)
-			alloc->last += prandom_u32() % RANDOM_SKIP;
+			alloc->last += prandom_u32_max(RANDOM_SKIP);
 		else
 			alloc->last = obj + 1;
 		if (alloc->last >= alloc->max)
@@ -87,7 +87,7 @@ int c4iw_id_table_alloc(struct c4iw_id_table *alloc, u32 start, u32 num,
 	alloc->start = start;
 	alloc->flags = flags;
 	if (flags & C4IW_ID_TABLE_F_RANDOM)
-		alloc->last = prandom_u32() % RANDOM_SKIP;
+		alloc->last = prandom_u32_max(RANDOM_SKIP);
 	else
 		alloc->last = 0;
 	alloc->max  = num;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index abf8f5eb0a1c8..77ecf5fa6c1b4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -96,8 +96,8 @@ static void mmc_should_fail_request(struct mmc_host *host,
 	    !should_fail(&host->fail_mmc_request, data->blksz * data->blocks))
 		return;
 
-	data->error = data_errors[prandom_u32() % ARRAY_SIZE(data_errors)];
-	data->bytes_xfered = (prandom_u32() % (data->bytes_xfered >> 9)) << 9;
+	data->error = data_errors[prandom_u32_max(ARRAY_SIZE(data_errors))];
+	data->bytes_xfered = prandom_u32_max(data->bytes_xfered >> 9) << 9;
 }
 
 #else /* CONFIG_FAIL_MMC_REQUEST */
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 9a70754a61efe..3bed07d9feab3 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -1391,9 +1391,9 @@ static void do_bit_flips(struct nandsim *ns, int num)
 	if (bitflips && prandom_u32() < (1 << 22)) {
 		int flips = 1;
 		if (bitflips > 1)
-			flips = (prandom_u32() % (int) bitflips) + 1;
+			flips = prandom_u32_max(bitflips) + 1;
 		while (flips--) {
-			int pos = prandom_u32() % (num * 8);
+			int pos = prandom_u32_max(num * 8);
 			ns->buf.byte[pos / 8] ^= (1 << (pos % 8));
 			NS_WARN("read_page: flipping bit %d in page %d "
 				"reading from %d ecc: corrected=%u failed=%u\n",
diff --git a/drivers/mtd/tests/mtd_nandecctest.c b/drivers/mtd/tests/mtd_nandecctest.c
index 13bca9ea0caef..aac8aa8dac96c 100644
--- a/drivers/mtd/tests/mtd_nandecctest.c
+++ b/drivers/mtd/tests/mtd_nandecctest.c
@@ -47,7 +47,7 @@ struct nand_ecc_test {
 static void single_bit_error_data(void *error_data, void *correct_data,
 				size_t size)
 {
-	unsigned int offset = prandom_u32() % (size * BITS_PER_BYTE);
+	unsigned int offset = prandom_u32_max(size * BITS_PER_BYTE);
 
 	memcpy(error_data, correct_data, size);
 	__change_bit_le(offset, error_data);
@@ -58,9 +58,9 @@ static void double_bit_error_data(void *error_data, void *correct_data,
 {
 	unsigned int offset[2];
 
-	offset[0] = prandom_u32() % (size * BITS_PER_BYTE);
+	offset[0] = prandom_u32_max(size * BITS_PER_BYTE);
 	do {
-		offset[1] = prandom_u32() % (size * BITS_PER_BYTE);
+		offset[1] = prandom_u32_max(size * BITS_PER_BYTE);
 	} while (offset[0] == offset[1]);
 
 	memcpy(error_data, correct_data, size);
@@ -71,7 +71,7 @@ static void double_bit_error_data(void *error_data, void *correct_data,
 
 static unsigned int random_ecc_bit(size_t size)
 {
-	unsigned int offset = prandom_u32() % (3 * BITS_PER_BYTE);
+	unsigned int offset = prandom_u32_max(3 * BITS_PER_BYTE);
 
 	if (size == 256) {
 		/*
@@ -79,7 +79,7 @@ static unsigned int random_ecc_bit(size_t size)
 		 * and 17th bit) in ECC code for 256 byte data block
 		 */
 		while (offset == 16 || offset == 17)
-			offset = prandom_u32() % (3 * BITS_PER_BYTE);
+			offset = prandom_u32_max(3 * BITS_PER_BYTE);
 	}
 
 	return offset;
diff --git a/drivers/mtd/tests/stresstest.c b/drivers/mtd/tests/stresstest.c
index cb29c8c1b3703..58b307fa85f5d 100644
--- a/drivers/mtd/tests/stresstest.c
+++ b/drivers/mtd/tests/stresstest.c
@@ -45,9 +45,8 @@ static int rand_eb(void)
 	unsigned int eb;
 
 again:
-	eb = prandom_u32();
 	/* Read or write up 2 eraseblocks at a time - hence 'ebcnt - 1' */
-	eb %= (ebcnt - 1);
+	eb = prandom_u32_max(ebcnt - 1);
 	if (bbt[eb])
 		goto again;
 	return eb;
@@ -55,20 +54,12 @@ static int rand_eb(void)
 
 static int rand_offs(void)
 {
-	unsigned int offs;
-
-	offs = prandom_u32();
-	offs %= bufsize;
-	return offs;
+	return prandom_u32_max(bufsize);
 }
 
 static int rand_len(int offs)
 {
-	unsigned int len;
-
-	len = prandom_u32();
-	len %= (bufsize - offs);
-	return len;
+	return prandom_u32_max(bufsize - offs);
 }
 
 static int do_read(void)
diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 54646c2c2744a..9fddb9416cfe9 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -598,7 +598,7 @@ int ubi_dbg_power_cut(struct ubi_device *ubi, int caller)
 
 		if (ubi->dbg.power_cut_max > ubi->dbg.power_cut_min) {
 			range = ubi->dbg.power_cut_max - ubi->dbg.power_cut_min;
-			ubi->dbg.power_cut_counter += prandom_u32() % range;
+			ubi->dbg.power_cut_counter += prandom_u32_max(range);
 		}
 		return 0;
 	}
diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index 61ab7d21f6bd6..895f8ef8b50ab 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -4106,8 +4106,7 @@ static int cnic_cm_alloc_mem(struct cnic_dev *dev)
 	for (i = 0; i < MAX_CM_SK_TBL_SZ; i++)
 		atomic_set(&cp->csk_tbl[i].ref_count, 0);
 
-	port_id = prandom_u32();
-	port_id %= CNIC_LOCAL_PORT_RANGE;
+	port_id = prandom_u32_max(CNIC_LOCAL_PORT_RANGE);
 	if (cnic_init_id_tbl(&cp->csk_port_tbl, CNIC_LOCAL_PORT_RANGE,
 			     CNIC_LOCAL_PORT_MIN, port_id)) {
 		cnic_cm_free_mem(dev);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 1f5deea5a288e..84b359ccf669d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1107,7 +1107,7 @@ static void brcmf_p2p_afx_handler(struct work_struct *work)
 	if (afx_hdl->is_listen && afx_hdl->my_listen_chan)
 		/* 100ms ~ 300ms */
 		err = brcmf_p2p_discover_listen(p2p, afx_hdl->my_listen_chan,
-						100 * (1 + prandom_u32() % 3));
+						100 * (1 + prandom_u32_max(3)));
 	else
 		err = brcmf_p2p_act_frm_search(p2p, afx_hdl->peer_listen_chan);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index b78992e341d5e..b740cda037d75 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1132,7 +1132,7 @@ static void iwl_mvm_mac_ctxt_cmd_fill_ap(struct iwl_mvm *mvm,
 			iwl_mvm_mac_ap_iterator, &data);
 
 		if (data.beacon_device_ts) {
-			u32 rand = (prandom_u32() % (64 - 36)) + 36;
+			u32 rand = prandom_u32_max(64 - 36) + 36;
 			mvmvif->ap_beacon_time = data.beacon_device_ts +
 				ieee80211_tu_to_usec(data.beacon_int * rand /
 						     100);
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index acb930b8c6a64..3f29bbb605e24 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -609,7 +609,7 @@ static int qedi_cm_alloc_mem(struct qedi_ctx *qedi)
 				sizeof(struct qedi_endpoint *)), GFP_KERNEL);
 	if (!qedi->ep_tbl)
 		return -ENOMEM;
-	port_id = prandom_u32() % QEDI_LOCAL_PORT_RANGE;
+	port_id = prandom_u32_max(QEDI_LOCAL_PORT_RANGE);
 	if (qedi_init_id_tbl(&qedi->lcl_port_tbl, QEDI_LOCAL_PORT_RANGE,
 			     QEDI_LOCAL_PORT_MIN, port_id)) {
 		qedi_cm_free_mem(qedi);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index c07407586ce87..aa658f35ada26 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -332,7 +332,7 @@ static int ceph_fill_fragtree(struct inode *inode,
 	if (nsplits != ci->i_fragtree_nsplits) {
 		update = true;
 	} else if (nsplits) {
-		i = prandom_u32() % nsplits;
+		i = prandom_u32_max(nsplits);
 		id = le32_to_cpu(fragtree->splits[i].frag);
 		if (!__ceph_find_frag(ci, id))
 			update = true;
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 471bac335fae6..03b321f3459f1 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -34,7 +34,7 @@ int ceph_mdsmap_get_random_mds(struct ceph_mdsmap *m)
 		return -1;
 
 	/* pick */
-	n = prandom_u32() % n;
+	n = prandom_u32_max(n);
 	for (j = 0, i = 0; i < m->m_num_mds; i++) {
 		if (m->m_info[i].state > 0)
 			j++;
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index fda7d3f5b4be5..6829910d14255 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -281,8 +281,7 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent)
 		int best_ndir = inodes_per_group;
 		int best_group = -1;
 
-		group = prandom_u32();
-		parent_group = (unsigned)group % ngroups;
+		parent_group = prandom_u32_max(ngroups);
 		for (i = 0; i < ngroups; i++) {
 			group = (parent_group + i) % ngroups;
 			desc = ext2_get_group_desc (sb, group, NULL);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 71e2b80ff4aae..eea9d4920bf78 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3183,8 +3183,8 @@ static int ext4_lazyinit_thread(void *arg)
 			}
 			if (!progress) {
 				elr->lr_next_sched = jiffies +
-					(prandom_u32()
-					 % (EXT4_DEF_LI_MAX_START_DELAY * HZ));
+				    prandom_u32_max(EXT4_DEF_LI_MAX_START_DELAY
+						    * HZ);
 			}
 			if (time_before(elr->lr_next_sched, next_wakeup))
 				next_wakeup = elr->lr_next_sched;
@@ -3327,8 +3327,8 @@ static struct ext4_li_request *ext4_li_request_new(struct super_block *sb,
 	 * spread the inode table initialization requests
 	 * better.
 	 */
-	elr->lr_next_sched = jiffies + (prandom_u32() %
-				(EXT4_DEF_LI_MAX_START_DELAY * HZ));
+	elr->lr_next_sched = jiffies +
+			prandom_u32_max(EXT4_DEF_LI_MAX_START_DELAY * HZ);
 	return elr;
 }
 
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 3d8d8eaea6c66..43ed46d488fd2 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2465,13 +2465,13 @@ static int power_cut_emulated(struct ubifs_info *c, int lnum, int write)
 			if (chance(1, 2)) {
 				d->pc_delay = 1;
 				/* Fail within 1 minute */
-				delay = prandom_u32() % 60000;
+				delay = prandom_u32_max(60000);
 				d->pc_timeout = jiffies;
 				d->pc_timeout += msecs_to_jiffies(delay);
 				ubifs_warn(c, "failing after %lums", delay);
 			} else {
 				d->pc_delay = 2;
-				delay = prandom_u32() % 10000;
+				delay = prandom_u32_max(10000);
 				/* Fail within 10000 operations */
 				d->pc_cnt_max = delay;
 				ubifs_warn(c, "failing after %lu calls", delay);
@@ -2551,7 +2551,7 @@ static int corrupt_data(const struct ubifs_info *c, const void *buf,
 	unsigned int from, to, ffs = chance(1, 2);
 	unsigned char *p = (void *)buf;
 
-	from = prandom_u32() % len;
+	from = prandom_u32_max(len);
 	/* Corruption span max to end of write unit */
 	to = min(len, ALIGN(from + 1, c->max_write_size));
 
diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
index ff5e0411cf2d1..29ba1bae1c366 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -1977,21 +1977,21 @@ static int dbg_populate_lsave(struct ubifs_info *c)
 		c->lsave[i] = c->main_first;
 
 	list_for_each_entry(lprops, &c->empty_list, list)
-		c->lsave[prandom_u32() % c->lsave_cnt] = lprops->lnum;
+		c->lsave[prandom_u32_max(c->lsave_cnt)] = lprops->lnum;
 	list_for_each_entry(lprops, &c->freeable_list, list)
-		c->lsave[prandom_u32() % c->lsave_cnt] = lprops->lnum;
+		c->lsave[prandom_u32_max(c->lsave_cnt)] = lprops->lnum;
 	list_for_each_entry(lprops, &c->frdi_idx_list, list)
-		c->lsave[prandom_u32() % c->lsave_cnt] = lprops->lnum;
+		c->lsave[prandom_u32_max(c->lsave_cnt)] = lprops->lnum;
 
 	heap = &c->lpt_heap[LPROPS_DIRTY_IDX - 1];
 	for (i = 0; i < heap->cnt; i++)
-		c->lsave[prandom_u32() % c->lsave_cnt] = heap->arr[i]->lnum;
+		c->lsave[prandom_u32_max(c->lsave_cnt)] = heap->arr[i]->lnum;
 	heap = &c->lpt_heap[LPROPS_DIRTY - 1];
 	for (i = 0; i < heap->cnt; i++)
-		c->lsave[prandom_u32() % c->lsave_cnt] = heap->arr[i]->lnum;
+		c->lsave[prandom_u32_max(c->lsave_cnt)] = heap->arr[i]->lnum;
 	heap = &c->lpt_heap[LPROPS_FREE - 1];
 	for (i = 0; i < heap->cnt; i++)
-		c->lsave[prandom_u32() % c->lsave_cnt] = heap->arr[i]->lnum;
+		c->lsave[prandom_u32_max(c->lsave_cnt)] = heap->arr[i]->lnum;
 
 	return 1;
 }
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index 331765afc53e4..ebb5f93a2381d 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -252,7 +252,7 @@ xfs_errortag_test(
 
 	ASSERT(error_tag < XFS_ERRTAG_MAX);
 	randfactor = mp->m_errortag[error_tag];
-	if (!randfactor || prandom_u32() % randfactor)
+	if (!randfactor || prandom_u32_max(randfactor))
 		return false;
 
 	xfs_warn_ratelimited(mp,
diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index 5637c5711db94..201b7c7881646 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -137,8 +137,8 @@ static int __init find_bit_test(void)
 	bitmap_zero(bitmap2, BITMAP_LEN);
 
 	while (nbits--) {
-		__set_bit(prandom_u32() % BITMAP_LEN, bitmap);
-		__set_bit(prandom_u32() % BITMAP_LEN, bitmap2);
+		__set_bit(prandom_u32_max(BITMAP_LEN), bitmap);
+		__set_bit(prandom_u32_max(BITMAP_LEN), bitmap2);
 	}
 
 	test_find_next_bit(bitmap, BITMAP_LEN);
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index af88d1346dd74..ac5552dca4532 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -367,7 +367,8 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 
 	if (depth && !round_robin) {
 		for_each_possible_cpu(i)
-			*per_cpu_ptr(sbq->alloc_hint, i) = prandom_u32() % depth;
+			*per_cpu_ptr(sbq->alloc_hint, i) =
+							prandom_u32_max(depth);
 	}
 
 	sbq->min_shallow_depth = UINT_MAX;
@@ -426,7 +427,7 @@ int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 	hint = this_cpu_read(*sbq->alloc_hint);
 	depth = READ_ONCE(sbq->sb.depth);
 	if (unlikely(hint >= depth)) {
-		hint = depth ? prandom_u32() % depth : 0;
+		hint = depth ? prandom_u32_max(depth) : 0;
 		this_cpu_write(*sbq->alloc_hint, hint);
 	}
 	nr = sbitmap_get(&sbq->sb, hint, sbq->round_robin);
@@ -457,7 +458,7 @@ int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
 	hint = this_cpu_read(*sbq->alloc_hint);
 	depth = READ_ONCE(sbq->sb.depth);
 	if (unlikely(hint >= depth)) {
-		hint = depth ? prandom_u32() % depth : 0;
+		hint = depth ? prandom_u32_max(depth) : 0;
 		this_cpu_write(*sbq->alloc_hint, hint);
 	}
 	nr = sbitmap_get_shallow(&sbq->sb, hint, shallow_depth);
diff --git a/lib/test_list_sort.c b/lib/test_list_sort.c
index 1f017d3b610ee..7c8dbd653a7a9 100644
--- a/lib/test_list_sort.c
+++ b/lib/test_list_sort.c
@@ -86,7 +86,7 @@ static int __init list_sort_test(void)
 			goto exit;
 
 		 /* force some equivalencies */
-		el->value = prandom_u32() % (TEST_LIST_LEN / 3);
+		el->value = prandom_u32_max(TEST_LIST_LEN / 3);
 		el->serial = i;
 		el->poison1 = TEST_POISON1;
 		el->poison2 = TEST_POISON2;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index bb3261d45b6a3..efe7d972fdde3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3204,7 +3204,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		 * select a random position to start with to help wear leveling
 		 * SSD
 		 */
-		p->cluster_next = 1 + (prandom_u32() % p->highest_bit);
+		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);
 		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
 
 		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index d88a4de022372..46c5cd9f8019e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -280,7 +280,7 @@ batadv_iv_ogm_emit_send_time(const struct batadv_priv *bat_priv)
 	unsigned int msecs;
 
 	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
-	msecs += prandom_u32() % (2 * BATADV_JITTER);
+	msecs += prandom_u32_max(2 * BATADV_JITTER);
 
 	return jiffies + msecs_to_jiffies(msecs);
 }
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 2614a9caee008..13c6f5150dc00 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -49,7 +49,7 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 	unsigned int msecs;
 
 	msecs = atomic_read(&hard_iface->bat_v.elp_interval) - BATADV_JITTER;
-	msecs += prandom_u32() % (2 * BATADV_JITTER);
+	msecs += prandom_u32_max(2 * BATADV_JITTER);
 
 	queue_delayed_work(batadv_event_workqueue, &hard_iface->bat_v.elp_wq,
 			   msecs_to_jiffies(msecs));
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 714ce56cfcc82..411ce5fc6492f 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -107,7 +107,7 @@ static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 		return;
 
 	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
-	msecs += prandom_u32() % (2 * BATADV_JITTER);
+	msecs += prandom_u32_max(2 * BATADV_JITTER);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->bat_v.ogm_wq,
 			   msecs_to_jiffies(msecs));
 }
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 9d9e4e4ea600e..b5db5c05843cf 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -155,7 +155,7 @@ static void pick_new_mon(struct ceph_mon_client *monc)
 				max--;
 		}
 
-		n = prandom_u32() % max;
+		n = prandom_u32_max(max);
 		if (o >= 0 && n >= o)
 			n++;
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 789a73aa7bd87..cc00feb89f7f8 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -112,7 +112,7 @@ static void neigh_cleanup_and_release(struct neighbour *neigh)
 
 unsigned long neigh_rand_reach_time(unsigned long base)
 {
-	return base ? (prandom_u32() % base) + (base >> 1) : 0;
+	return base ? prandom_u32_max(base) + (base >> 1) : 0;
 }
 EXPORT_SYMBOL(neigh_rand_reach_time);
 
@@ -1567,8 +1567,8 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 {
 	unsigned long now = jiffies;
 
-	unsigned long sched_next = now + (prandom_u32() %
-					  NEIGH_VAR(p, PROXY_DELAY));
+	unsigned long sched_next = now +
+			prandom_u32_max(NEIGH_VAR(p, PROXY_DELAY));
 
 	if (tbl->proxy_queue.qlen > NEIGH_VAR(p, PROXY_QLEN)) {
 		kfree_skb(skb);
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 294bfcf0ce0eb..f2b6460bd88cc 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2216,7 +2216,7 @@ static inline int f_pick(struct pktgen_dev *pkt_dev)
 				pkt_dev->curfl = 0; /*reset */
 		}
 	} else {
-		flow = prandom_u32() % pkt_dev->cflows;
+		flow = prandom_u32_max(pkt_dev->cflows);
 		pkt_dev->curfl = flow;
 
 		if (pkt_dev->flows[flow].count > pkt_dev->lflow) {
@@ -2272,7 +2272,7 @@ static void set_cur_queue_map(struct pktgen_dev *pkt_dev)
 	else if (pkt_dev->queue_map_min <= pkt_dev->queue_map_max) {
 		__u16 t;
 		if (pkt_dev->flags & F_QUEUE_MAP_RND) {
-			t = prandom_u32() %
+			t = prandom_u32_max
 				(pkt_dev->queue_map_max -
 				 pkt_dev->queue_map_min + 1)
 				+ pkt_dev->queue_map_min;
@@ -2304,7 +2304,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 		__u32 tmp;
 
 		if (pkt_dev->flags & F_MACSRC_RND)
-			mc = prandom_u32() % pkt_dev->src_mac_count;
+			mc = prandom_u32_max(pkt_dev->src_mac_count);
 		else {
 			mc = pkt_dev->cur_src_mac_offset++;
 			if (pkt_dev->cur_src_mac_offset >=
@@ -2330,7 +2330,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 		__u32 tmp;
 
 		if (pkt_dev->flags & F_MACDST_RND)
-			mc = prandom_u32() % pkt_dev->dst_mac_count;
+			mc = prandom_u32_max(pkt_dev->dst_mac_count);
 
 		else {
 			mc = pkt_dev->cur_dst_mac_offset++;
@@ -2371,7 +2371,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 
 	if (pkt_dev->udp_src_min < pkt_dev->udp_src_max) {
 		if (pkt_dev->flags & F_UDPSRC_RND)
-			pkt_dev->cur_udp_src = prandom_u32() %
+			pkt_dev->cur_udp_src = prandom_u32_max
 				(pkt_dev->udp_src_max - pkt_dev->udp_src_min)
 				+ pkt_dev->udp_src_min;
 
@@ -2384,7 +2384,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 
 	if (pkt_dev->udp_dst_min < pkt_dev->udp_dst_max) {
 		if (pkt_dev->flags & F_UDPDST_RND) {
-			pkt_dev->cur_udp_dst = prandom_u32() %
+			pkt_dev->cur_udp_dst = prandom_u32_max
 				(pkt_dev->udp_dst_max - pkt_dev->udp_dst_min)
 				+ pkt_dev->udp_dst_min;
 		} else {
@@ -2401,7 +2401,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 		if (imn < imx) {
 			__u32 t;
 			if (pkt_dev->flags & F_IPSRC_RND)
-				t = prandom_u32() % (imx - imn) + imn;
+				t = prandom_u32_max(imx - imn) + imn;
 			else {
 				t = ntohl(pkt_dev->cur_saddr);
 				t++;
@@ -2423,8 +2423,8 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 				if (pkt_dev->flags & F_IPDST_RND) {
 
 					do {
-						t = prandom_u32() %
-							(imx - imn) + imn;
+						t = prandom_u32_max(imx - imn) +
+						       imn;
 						s = htonl(t);
 					} while (ipv4_is_loopback(s) ||
 						ipv4_is_multicast(s) ||
@@ -2471,7 +2471,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 	if (pkt_dev->min_pkt_size < pkt_dev->max_pkt_size) {
 		__u32 t;
 		if (pkt_dev->flags & F_TXSIZE_RND) {
-			t = prandom_u32() %
+			t = prandom_u32_max
 				(pkt_dev->max_pkt_size - pkt_dev->min_pkt_size)
 				+ pkt_dev->min_pkt_size;
 		} else {
diff --git a/net/core/stream.c b/net/core/stream.c
index 4f1d4aa5fb38d..cf9b67c5b39ca 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -123,7 +123,7 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 
 	if (sk_stream_memory_free(sk))
-		current_timeo = vm_wait = (prandom_u32() % (HZ / 5)) + 2;
+		current_timeo = vm_wait = prandom_u32_max(HZ / 5) + 2;
 
 	add_wait_queue(sk_sleep(sk), &wait);
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 3b9c7a2725a99..8c429dd3aabc4 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -215,7 +215,7 @@ static void igmp_stop_timer(struct ip_mc_list *im)
 /* It must be called with locked im->lock */
 static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
 {
-	int tv = prandom_u32() % max_delay;
+	int tv = prandom_u32_max(max_delay);
 
 	im->tm_running = 1;
 	if (!mod_timer(&im->timer, jiffies+tv+2))
@@ -224,7 +224,7 @@ static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
 
 static void igmp_gq_start_timer(struct in_device *in_dev)
 {
-	int tv = prandom_u32() % in_dev->mr_maxdelay;
+	int tv = prandom_u32_max(in_dev->mr_maxdelay);
 	unsigned long exp = jiffies + tv + 2;
 
 	if (in_dev->mr_gq_running &&
@@ -238,7 +238,7 @@ static void igmp_gq_start_timer(struct in_device *in_dev)
 
 static void igmp_ifc_start_timer(struct in_device *in_dev, int delay)
 {
-	int tv = prandom_u32() % delay;
+	int tv = prandom_u32_max(delay);
 
 	if (!mod_timer(&in_dev->mr_ifc_timer, jiffies+tv+2))
 		in_dev_hold(in_dev);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 159513ce85114..4d59bbab0ac5a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -200,7 +200,7 @@ inet_csk_find_open_port(struct sock *sk, struct inet_bind_bucket **tb_ret, int *
 	if (likely(remaining > 1))
 		remaining &= ~1U;
 
-	offset = prandom_u32() % remaining;
+	offset = prandom_u32_max(remaining);
 	/* __inet_hash_connect() favors ports having @low parity
 	 * We do the opposite to not pollute connect() users.
 	 */
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 46d614b611db2..ec3f472bc5a8f 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3921,7 +3921,7 @@ static void addrconf_dad_kick(struct inet6_ifaddr *ifp)
 	if (ifp->flags & IFA_F_OPTIMISTIC)
 		rand_num = 0;
 	else
-		rand_num = prandom_u32() % (idev->cnf.rtr_solicit_delay ? : 1);
+		rand_num = prandom_u32_max(idev->cnf.rtr_solicit_delay ? : 1);
 
 	nonce = 0;
 	if (idev->cnf.enhanced_dad ||
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index eaa4c2cc2fbb2..e0b5810c3d7fe 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1032,7 +1032,7 @@ bool ipv6_chk_mcast_addr(struct net_device *dev, const struct in6_addr *group,
 
 static void mld_gq_start_timer(struct inet6_dev *idev)
 {
-	unsigned long tv = prandom_u32() % idev->mc_maxdelay;
+	unsigned long tv = prandom_u32_max(idev->mc_maxdelay);
 
 	idev->mc_gq_running = 1;
 	if (!mod_timer(&idev->mc_gq_timer, jiffies+tv+2))
@@ -1048,7 +1048,7 @@ static void mld_gq_stop_timer(struct inet6_dev *idev)
 
 static void mld_ifc_start_timer(struct inet6_dev *idev, unsigned long delay)
 {
-	unsigned long tv = prandom_u32() % delay;
+	unsigned long tv = prandom_u32_max(delay);
 
 	if (!mod_timer(&idev->mc_ifc_timer, jiffies+tv+2))
 		in6_dev_hold(idev);
@@ -1063,7 +1063,7 @@ static void mld_ifc_stop_timer(struct inet6_dev *idev)
 
 static void mld_dad_start_timer(struct inet6_dev *idev, unsigned long delay)
 {
-	unsigned long tv = prandom_u32() % delay;
+	unsigned long tv = prandom_u32_max(delay);
 
 	if (!mod_timer(&idev->mc_dad_timer, jiffies+tv+2))
 		in6_dev_hold(idev);
@@ -1094,7 +1094,7 @@ static void igmp6_group_queried(struct ifmcaddr6 *ma, unsigned long resptime)
 	}
 
 	if (delay >= resptime)
-		delay = prandom_u32() % resptime;
+		delay = prandom_u32_max(resptime);
 
 	ma->mca_timer.expires = jiffies + delay;
 	if (!mod_timer(&ma->mca_timer, jiffies + delay))
@@ -2416,7 +2416,7 @@ static void igmp6_join_group(struct ifmcaddr6 *ma)
 
 	igmp6_send(&ma->mca_addr, ma->idev->dev, ICMPV6_MGM_REPORT);
 
-	delay = prandom_u32() % unsolicited_report_interval(ma->idev);
+	delay = prandom_u32_max(unsolicited_report_interval(ma->idev));
 
 	spin_lock_bh(&ma->mca_lock);
 	if (del_timer(&ma->mca_timer)) {
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 20edb7c25e221..9068e0b13e0be 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1305,7 +1305,7 @@ static bool fanout_flow_is_huge(struct packet_sock *po, struct sk_buff *skb)
 		if (READ_ONCE(history[i]) == rxhash)
 			count++;
 
-	victim = prandom_u32() % ROLLOVER_HLEN;
+	victim = prandom_u32_max(ROLLOVER_HLEN);
 
 	/* Avoid dirtying the cache line if possible */
 	if (READ_ONCE(history[victim]) != rxhash)
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index 4160657727196..56afdde2bc558 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -26,7 +26,7 @@ static struct tc_action_ops act_gact_ops;
 static int gact_net_rand(struct tcf_gact *gact)
 {
 	smp_rmb(); /* coupled with smp_wmb() in tcf_gact_init() */
-	if (prandom_u32() % gact->tcfg_pval)
+	if (prandom_u32_max(gact->tcfg_pval))
 		return gact->tcf_action;
 	return gact->tcfg_paction;
 }
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index ce948c1e24dc5..41701acc490e6 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -172,7 +172,7 @@ static int tcf_sample_act(struct sk_buff *skb, const struct tc_action *a,
 	psample_group = rcu_dereference_bh(s->psample_group);
 
 	/* randomly sample packets according to rate */
-	if (psample_group && (prandom_u32() % s->rate == 0)) {
+	if (psample_group && prandom_u32_max(s->rate) == 0) {
 		if (!skb_at_tc_ingress(skb)) {
 			iif = skb->skb_iif;
 			oif = skb->dev->ifindex;
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 42e557d48e4e3..7b7503326faf5 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -513,7 +513,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			goto finish_segs;
 		}
 
-		skb->data[prandom_u32() % skb_headlen(skb)] ^=
+		skb->data[prandom_u32_max(skb_headlen(skb))] ^=
 			1<<(prandom_u32() % 8);
 	}
 
@@ -632,9 +632,8 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 
 	if (!q->slot_dist)
 		next_delay = q->slot_config.min_delay +
-				(prandom_u32() *
-				 (q->slot_config.max_delay -
-				  q->slot_config.min_delay) >> 32);
+			prandom_u32_max(q->slot_config.max_delay -
+					q->slot_config.min_delay);
 	else
 		next_delay = tabledist(q->slot_config.dist_delay,
 				       (s32)(q->slot_config.dist_jitter),
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 0b485952a71c1..7acb374ed8596 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8286,7 +8286,7 @@ static int sctp_get_port_local(struct sock *sk, union sctp_addr *addr)
 
 		inet_get_local_port_range(net, &low, &high);
 		remaining = (high - low) + 1;
-		rover = prandom_u32() % remaining + low;
+		rover = prandom_u32_max(remaining) + low;
 
 		do {
 			rover++;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index d86c664ea6afc..f90727d0a9c48 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1699,7 +1699,7 @@ static int xs_get_random_port(void)
 	if (max < min)
 		return -EADDRINUSE;
 	range = max - min + 1;
-	rand = (unsigned short) prandom_u32() % range;
+	rand = (unsigned short) prandom_u32_max(range);
 	return rand + min;
 }
 
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 693e8902161ef..1118e6815256c 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2151,8 +2151,7 @@ static bool tipc_sk_filter_connect(struct tipc_sock *tsk, struct sk_buff *skb)
 		/* Prepare for new setup attempt if we have a SYN clone */
 		if (skb_queue_empty(&sk->sk_write_queue))
 			break;
-		get_random_bytes(&delay, 2);
-		delay %= (tsk->conn_timeout / 4);
+		delay = get_random_max(tsk->conn_timeout / 4);
 		delay = msecs_to_jiffies(delay + 100);
 		sk_reset_timer(sk, &sk->sk_timer, jiffies + delay);
 		return false;
@@ -2917,7 +2916,7 @@ static int tipc_sk_insert(struct tipc_sock *tsk)
 	struct net *net = sock_net(sk);
 	struct tipc_net *tn = net_generic(net, tipc_net_id);
 	u32 remaining = (TIPC_MAX_PORT - TIPC_MIN_PORT) + 1;
-	u32 portid = prandom_u32() % remaining + TIPC_MIN_PORT;
+	u32 portid = prandom_u32_max(remaining) + TIPC_MIN_PORT;
 
 	while (remaining--) {
 		portid++;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f3423562d9336..342d4fabc722e 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1991,7 +1991,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high)
 	} else {
 		u32 spi = 0;
 		for (h = 0; h < high-low+1; h++) {
-			spi = low + prandom_u32()%(high-low+1);
+			spi = low + prandom_u32_max(high-low+1);
 			x0 = xfrm_state_lookup(net, mark, &x->id.daddr, htonl(spi), x->id.proto, x->props.family);
 			if (x0 == NULL) {
 				x->id.spi = htonl(spi);
-- 
2.26.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
