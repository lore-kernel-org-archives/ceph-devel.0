From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 23 Nov 2017 00:19:05 +0000 (UTC)
Message-ID: <5a1613f8c2f1d_4249ef531c690ec@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.hv1nn.shared.sendgrid.net ([167.89.100.17]:14237 "EHLO
        o2.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751504AbdKWATG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 22 Nov 2017 19:19:06 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0024p1las1.sendgrid.net (SG) with ESMTP id 3QKyR7GYSBaZnW1CdvIz4Q
        for <ceph-devel@vger.kernel.org>; Thu, 23 Nov 2017 00:19:05.261 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

200 new defect(s) introduced to ceph found with Coverity Scan.
24 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 200 defect(s)


** CID 200825:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/ixgbe/base/ixgbe_common.c: 4655 in ixgbe_set_fw_drv_ver_generic()


________________________________________________________________________________________________________
*** CID 200825:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/ixgbe/base/ixgbe_common.c: 4655 in ixgbe_set_fw_drv_ver_generic()
4649      *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
4650      **/
4651     s32 ixgbe_set_fw_drv_ver_generic(struct ixgbe_hw *hw, u8 maj, u8 min,
4652     				 u8 build, u8 sub, u16 len,
4653     				 const char *driver_ver)
4654     {
>>>     CID 200825:  Uninitialized variables  (UNINIT)
>>>     Declaring variable "fw_cmd" without initializer.
4655     	struct ixgbe_hic_drv_info fw_cmd;
4656     	int i;
4657     	s32 ret_val = IXGBE_SUCCESS;
4658     
4659     	DEBUGFUNC("ixgbe_set_fw_drv_ver_generic");
4660     	UNREFERENCED_2PARAMETER(len, driver_ver);

** CID 611045:  Control flow issues  (MISSING_BREAK)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_vf.c: 494 in e1000_promisc_set_vf()


________________________________________________________________________________________________________
*** CID 611045:  Control flow issues  (MISSING_BREAK)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_vf.c: 494 in e1000_promisc_set_vf()
488     	switch (type) {
489     	case e1000_promisc_multicast:
490     		msgbuf |= E1000_VF_SET_PROMISC_MULTICAST;
491     		break;
492     	case e1000_promisc_enabled:
493     		msgbuf |= E1000_VF_SET_PROMISC_MULTICAST;
>>>     CID 611045:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
494     	case e1000_promisc_unicast:
495     		msgbuf |= E1000_VF_SET_PROMISC_UNICAST;
496     	case e1000_promisc_disabled:
497     		break;
498     	default:
499     		return -E1000_ERR_MAC_INIT;

** CID 1008498:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/spdk/lib/nvme/nvme_ctrlr.c: 698 in nvme_ctrlr_set_num_qpairs()


________________________________________________________________________________________________________
*** CID 1008498:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/spdk/lib/nvme/nvme_ctrlr.c: 698 in nvme_ctrlr_set_num_qpairs()
692     	rc = nvme_ctrlr_cmd_set_num_queues(ctrlr, ctrlr->opts.num_io_queues,
693     					   nvme_completion_poll_cb, &status);
694     	if (rc != 0) {
695     		return rc;
696     	}
697     
>>>     CID 1008498:  Program hangs  (INFINITE_LOOP)
>>>     If "status.done == 0" is initially true then it will remain true.
698     	while (status.done == false) {
699     		spdk_nvme_qpair_process_completions(ctrlr->adminq, 0);
700     	}
701     	if (spdk_nvme_cpl_is_error(&status.cpl)) {
702     		SPDK_ERRLOG("nvme_set_num_queues failed!\n");
703     		return -ENXIO;

** CID 1008499:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/spdk/lib/nvme/nvme_ctrlr.c: 650 in nvme_ctrlr_identify()


________________________________________________________________________________________________________
*** CID 1008499:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/spdk/lib/nvme/nvme_ctrlr.c: 650 in nvme_ctrlr_identify()
644     	rc = nvme_ctrlr_cmd_identify_controller(ctrlr, &ctrlr->cdata,
645     						nvme_completion_poll_cb, &status);
646     	if (rc != 0) {
647     		return rc;
648     	}
649     
>>>     CID 1008499:  Program hangs  (INFINITE_LOOP)
>>>     If "status.done == 0" is initially true then it will remain true.
650     	while (status.done == false) {
651     		spdk_nvme_qpair_process_completions(ctrlr->adminq, 0);
652     	}
653     	if (spdk_nvme_cpl_is_error(&status.cpl)) {
654     		SPDK_ERRLOG("nvme_identify_controller failed!\n");
655     		return -ENXIO;

** CID 1107249:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/spdk/lib/nvme/nvme_ctrlr.c: 925 in nvme_ctrlr_configure_aer()


________________________________________________________________________________________________________
*** CID 1107249:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/spdk/lib/nvme/nvme_ctrlr.c: 925 in nvme_ctrlr_configure_aer()
919     	state.bits.reserved = 0;
920     	rc = nvme_ctrlr_cmd_set_async_event_config(ctrlr, state, nvme_completion_poll_cb, &status);
921     	if (rc != 0) {
922     		return rc;
923     	}
924     
>>>     CID 1107249:  Program hangs  (INFINITE_LOOP)
>>>     If "status.done == 0" is initially true then it will remain true.
925     	while (status.done == false) {
926     		spdk_nvme_qpair_process_completions(ctrlr->adminq, 0);
927     	}
928     	if (spdk_nvme_cpl_is_error(&status.cpl)) {
929     		SPDK_ERRLOG("nvme_ctrlr_cmd_set_async_event_config failed!\n");
930     		return 0;

** CID 1192229:  Integer handling issues  (BAD_SHIFT)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_vf.c: 377 in e1000_hash_mc_addr_vf()


________________________________________________________________________________________________________
*** CID 1192229:  Integer handling issues  (BAD_SHIFT)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_vf.c: 377 in e1000_hash_mc_addr_vf()
371     	 * The bit_shift is the number of left-shifts
372     	 * where 0xFF would still fall within the hash mask.
373     	 */
374     	while (hash_mask >> bit_shift != 0xFF)
375     		bit_shift++;
376     
>>>     CID 1192229:  Integer handling issues  (BAD_SHIFT)
>>>     In expression "mc_addr[4] >> 8 - bit_shift", right shifting "mc_addr[4]" by more than 7 bits always yields zero.  The shift amount, "8 - bit_shift", is 8.
377     	hash_value = hash_mask & (((mc_addr[4] >> (8 - bit_shift)) |
378     				  (((u16) mc_addr[5]) << bit_shift)));
379     
380     	return hash_value;
381     }
382     

** CID 1194315:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/sfc/base/efx_ev.c: 416 in efx_ev_qpoll()


________________________________________________________________________________________________________
*** CID 1194315:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/sfc/base/efx_ev.c: 416 in efx_ev_qpoll()
410     		/* Read up until the end of the batch period */
411     		batch = EFX_EV_BATCH - (count & (EFX_EV_BATCH - 1));
412     		offset = (count & eep->ee_mask) * sizeof (efx_qword_t);
413     		for (total = 0; total < batch; ++total) {
414     			EFSYS_MEM_READQ(eep->ee_esmp, offset, &(ev[total]));
415     
>>>     CID 1194315:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized element of array "ev[total].eq_u64".
416     			if (!EFX_EV_PRESENT(ev[total]))
417     				break;
418     
419     			EFSYS_PROBE3(event, unsigned int, eep->ee_index,
420     			    uint32_t, EFX_QWORD_FIELD(ev[total], EFX_DWORD_1),
421     			    uint32_t, EFX_QWORD_FIELD(ev[total], EFX_DWORD_0));

** CID 1198913:  Integer handling issues  (BAD_SHIFT)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_mac.c: 566 in e1000_hash_mc_addr_generic()


________________________________________________________________________________________________________
*** CID 1198913:  Integer handling issues  (BAD_SHIFT)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_mac.c: 566 in e1000_hash_mc_addr_generic()
560     		break;
561     	case 3:
562     		bit_shift += 4;
563     		break;
564     	}
565     
>>>     CID 1198913:  Integer handling issues  (BAD_SHIFT)
>>>     In expression "mc_addr[4] >> 8 - bit_shift", right shifting "mc_addr[4]" by more than 7 bits always yields zero.  The shift amount, "8 - bit_shift", is 8.
566     	hash_value = hash_mask & (((mc_addr[4] >> (8 - bit_shift)) |
567     				  (((u16) mc_addr[5]) << bit_shift)));
568     
569     	return hash_value;
570     }
571     

** CID 1226963:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_ich8lan.c: 999 in e1000_set_eee_pchlan()


________________________________________________________________________________________________________
*** CID 1226963:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_ich8lan.c: 999 in e1000_set_eee_pchlan()
993     		ret_val = e1000_read_emi_reg_locked(hw, I82579_LPI_PLL_SHUT,
994     						    &data);
995     		if (ret_val)
996     			goto release;
997     
998     		data &= ~I82579_LPI_100_PLL_SHUT;
>>>     CID 1226963:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "e1000_write_emi_reg_locked(hw, 17426, data)" to "ret_val" here, but that stored value is overwritten before it can be used.
999     		ret_val = e1000_write_emi_reg_locked(hw, I82579_LPI_PLL_SHUT,
1000     						     data);
1001     	}
1002     
1003     	/* R/Clr IEEE MMD 3.1 bits 11:10 - Tx/Rx LPI Received */
1004     	ret_val = e1000_read_emi_reg_locked(hw, pcs_status, &data);

** CID 1234611:  Null pointer dereferences  (REVERSE_INULL)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/i40e/base/i40e_common.c: 336 in i40e_debug_aq()


________________________________________________________________________________________________________
*** CID 1234611:  Null pointer dereferences  (REVERSE_INULL)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/i40e/base/i40e_common.c: 336 in i40e_debug_aq()
330     {
331     	struct i40e_aq_desc *aq_desc = (struct i40e_aq_desc *)desc;
332     	u16 len = LE16_TO_CPU(aq_desc->datalen);
333     	u8 *buf = (u8 *)buffer;
334     	u16 i = 0;
335     
>>>     CID 1234611:  Null pointer dereferences  (REVERSE_INULL)
>>>     Null-checking "desc" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
336     	if ((!(mask & hw->debug_mask)) || (desc == NULL))
337     		return;
338     
339     	i40e_debug(hw, mask,
340     		   "AQ CMD: opcode 0x%04X, flags 0x%04X, datalen 0x%04X, retval 0x%04X\n",
341     		   LE16_TO_CPU(aq_desc->opcode),

** CID 1237013:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/spdk/lib/iscsi/iscsi.c: 184 in arc4random()
/home/brad/working/src/ceph/src/spdk/lib/iscsi/iscsi.c: 185 in arc4random()


________________________________________________________________________________________________________
*** CID 1237013:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/spdk/lib/iscsi/iscsi.c: 184 in arc4random()
178     	uint32_t r1, r2;
179     
180     	if (!spdk_arc4random_initialized) {
181     		srandomdev();
182     		spdk_arc4random_initialized = 1;
183     	}
>>>     CID 1237013:    (DC.WEAK_CRYPTO)
>>>     "random" should not be used for security related applications, as linear congruential algorithms are too easy to break.
184     	r1 = (uint32_t)(random() & 0xffff);
185     	r2 = (uint32_t)(random() & 0xffff);
186     	r = (r1 << 16) | r2;
187     	return r;
188     }
189     #endif /* HAVE_ARC4RANDOM */
/home/brad/working/src/ceph/src/spdk/lib/iscsi/iscsi.c: 185 in arc4random()
179     
180     	if (!spdk_arc4random_initialized) {
181     		srandomdev();
182     		spdk_arc4random_initialized = 1;
183     	}
184     	r1 = (uint32_t)(random() & 0xffff);
>>>     CID 1237013:    (DC.WEAK_CRYPTO)
>>>     "random" should not be used for security related applications, as linear congruential algorithms are too easy to break.
185     	r2 = (uint32_t)(random() & 0xffff);
186     	r = (r1 << 16) | r2;
187     	return r;
188     }
189     #endif /* HAVE_ARC4RANDOM */
190     

** CID 1260045:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/cxgbe/base/t4_hw.c: 3497 in t4_bar2_sge_qregs()


________________________________________________________________________________________________________
*** CID 1260045:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/cxgbe/base/t4_hw.c: 3497 in t4_bar2_sge_qregs()
3491     	/*
3492     	 * Calculate the basics of the BAR2 SGE Queue register area:
3493     	 *  o The BAR2 page the Queue registers will be in.
3494     	 *  o The BAR2 Queue ID.
3495     	 *  o The BAR2 Queue ID Offset into the BAR2 page.
3496     	 */
>>>     CID 1260045:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "(qid >> qpp_shift) << page_shift" with type "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "u64" (64 bits, unsigned).
3497     	bar2_page_offset = ((qid >> qpp_shift) << page_shift);
3498     	bar2_qid = qid & qpp_mask;
3499     	bar2_qid_offset = bar2_qid * SGE_UDB_SIZE;
3500     
3501     	/*
3502     	 * If the BAR2 Queue ID Offset is less than the Page Size, then the

** CID 1260094:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/ixgbe/base/ixgbe_x550.c: 3227 in ixgbe_read_ee_hostif_buffer_X550()


________________________________________________________________________________________________________
*** CID 1260094:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/ixgbe/base/ixgbe_x550.c: 3227 in ixgbe_read_ee_hostif_buffer_X550()
3221      *  Reads a 16 bit word(s) from the EEPROM using the hostif.
3222      **/
3223     s32 ixgbe_read_ee_hostif_buffer_X550(struct ixgbe_hw *hw,
3224     				     u16 offset, u16 words, u16 *data)
3225     {
3226     	const u32 mask = IXGBE_GSSR_SW_MNG_SM | IXGBE_GSSR_EEP_SM;
>>>     CID 1260094:  Uninitialized variables  (UNINIT)
>>>     Declaring variable "buffer" without initializer.
3227     	struct ixgbe_hic_read_shadow_ram buffer;
3228     	u32 current_word = 0;
3229     	u16 words_to_read;
3230     	s32 status;
3231     	u32 i;
3232     

** CID 1288953:  Control flow issues  (MISSING_BREAK)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/ixgbe/base/ixgbe_82599.c: 2027 in ixgbe_fdir_add_perfect_filter_82599()


________________________________________________________________________________________________________
*** CID 1288953:  Control flow issues  (MISSING_BREAK)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/ixgbe/base/ixgbe_82599.c: 2027 in ixgbe_fdir_add_perfect_filter_82599()
2021     	case IXGBE_ATR_FLOW_TYPE_SCTPV4:
2022     	case IXGBE_ATR_FLOW_TYPE_TUNNELED_SCTPV4:
2023     		if (input->formatted.dst_port || input->formatted.src_port) {
2024     			DEBUGOUT(" Error on src/dst port\n");
2025     			return IXGBE_ERR_CONFIG;
2026     		}
>>>     CID 1288953:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
2027     	case IXGBE_ATR_FLOW_TYPE_TCPV4:
2028     	case IXGBE_ATR_FLOW_TYPE_TUNNELED_TCPV4:
2029     	case IXGBE_ATR_FLOW_TYPE_UDPV4:
2030     	case IXGBE_ATR_FLOW_TYPE_TUNNELED_UDPV4:
2031     		input_mask->formatted.flow_type = IXGBE_ATR_L4TYPE_IPV6_MASK |
2032     						  IXGBE_ATR_L4TYPE_MASK;

** CID 1296016:  Incorrect expression  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_ich8lan.c: 4145 in e1000_update_nvm_checksum_spt()


________________________________________________________________________________________________________
*** CID 1296016:  Incorrect expression  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_ich8lan.c: 4145 in e1000_update_nvm_checksum_spt()
4139     
4140     	/* And invalidate the previously valid segment by setting
4141     	 * its signature word (0x13) high_byte to 0b. This can be
4142     	 * done without an erase because flash erase sets all bits
4143     	 * to 1's. We can write 1's to 0's without an erase
4144     	 */
>>>     CID 1296016:  Incorrect expression  (UNUSED_VALUE)
>>>     Assigning value from "(old_bank_offset + 19U) * 2U + 1U" to "act_offset" here, but that stored value is overwritten before it can be used.
4145     	act_offset = (old_bank_offset + E1000_ICH_NVM_SIG_WORD) * 2 + 1;
4146     
4147     	/* offset in words but we read dword*/
4148     	act_offset = old_bank_offset + E1000_ICH_NVM_SIG_WORD - 1;
4149     	ret_val = e1000_read_flash_dword_ich8lan(hw, act_offset, &dword);
4150     

** CID 1304883:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_ich8lan.c: 2620 in e1000_hv_phy_workarounds_ich8lan()


________________________________________________________________________________________________________
*** CID 1304883:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_ich8lan.c: 2620 in e1000_hv_phy_workarounds_ich8lan()
2614     	if (hw->phy.type == e1000_phy_82578) {
2615     		/* Return registers to default by doing a soft reset then
2616     		 * writing 0x3140 to the control register.
2617     		 */
2618     		if (hw->phy.revision < 2) {
2619     			e1000_phy_sw_reset_generic(hw);
>>>     CID 1304883:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "(*hw->phy.ops.write_reg)(hw, 0U, 12608)" to "ret_val" here, but that stored value is overwritten before it can be used.
2620     			ret_val = hw->phy.ops.write_reg(hw, PHY_CONTROL,
2621     							0x3140);
2622     		}
2623     	}
2624     
2625     	/* Select page 0 */

** CID 1304926:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_82543.c: 1233 in e1000_check_for_copper_link_82543()


________________________________________________________________________________________________________
*** CID 1304926:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/e1000/base/e1000_82543.c: 1233 in e1000_check_for_copper_link_82543()
1227     		 * interrupt state to its previous value except for the link
1228     		 * status change interrupt which will happened due to the
1229     		 * execution of this workaround.
1230     		 */
1231     		if (mac->forced_speed_duplex & E1000_ALL_10_SPEED) {
1232     			E1000_WRITE_REG(hw, E1000_IMC, 0xFFFFFFFF);
>>>     CID 1304926:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "e1000_polarity_reversal_workaround_82543(hw)" to "ret_val" here, but that stored value is overwritten before it can be used.
1233     			ret_val = e1000_polarity_reversal_workaround_82543(hw);
1234     			icr = E1000_READ_REG(hw, E1000_ICR);
1235     			E1000_WRITE_REG(hw, E1000_ICS, (icr & ~E1000_ICS_LSC));
1236     			E1000_WRITE_REG(hw, E1000_IMS, IMS_ENABLE_MASK);
1237     		}
1238     

** CID 1349648:  Control flow issues  (UNREACHABLE)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/sfc/base/efx_mon.c: 106 in efx_mon_init()


________________________________________________________________________________________________________
*** CID 1349648:  Control flow issues  (UNREACHABLE)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/sfc/base/efx_mon.c: 106 in efx_mon_init()
100     #endif
101     	default:
102     		rc = ENOTSUP;
103     		goto fail2;
104     	}
105     
>>>     CID 1349648:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "emp->em_emop = emop;".
106     	emp->em_emop = emop;
107     	return (0);
108     
109     fail2:
110     	EFSYS_PROBE(fail2);
111     

** CID 1349672:  Memory - illegal accesses  (INCOMPATIBLE_CAST)


________________________________________________________________________________________________________
*** CID 1349672:  Memory - illegal accesses  (INCOMPATIBLE_CAST)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/sfc/base/ef10_filter.c: 429 in ef10_filter_hash()
423     
424     	/*
425     	 * As the area of the efx_filter_spec_t we need to hash is DWORD
426     	 * aligned and an exact number of DWORDs in size we can use the
427     	 * optimised efx_hash_dwords() rather than efx_hash_bytes()
428     	 */
>>>     CID 1349672:  Memory - illegal accesses  (INCOMPATIBLE_CAST)
>>>     Pointer "&spec->efs_outer_vid" points to an object whose effective type is "unsigned short" (16 bits, unsigned) but is dereferenced as a wider "unsigned int" (32 bits, unsigned).  This may lead to memory corruption.
429     	return (efx_hash_dwords((const uint32_t *)&spec->efs_outer_vid,
430     			(sizeof (efx_filter_spec_t) -
431     			EFX_FIELD_OFFSET(efx_filter_spec_t, efs_outer_vid)) /
432     			sizeof (uint32_t), 0));
433     }
434     

** CID 1364784:  Memory - corruptions  (ARRAY_VS_SINGLETON)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/qede/qede_rxtx.c: 495 in qede_update_rx_prod()


________________________________________________________________________________________________________
*** CID 1364784:  Memory - corruptions  (ARRAY_VS_SINGLETON)
/home/brad/working/src/ceph/src/spdk/dpdk/drivers/net/qede/qede_rxtx.c: 495 in qede_update_rx_prod()
489     	/* Make sure that the BD and SGE data is updated before updating the
490     	 * producers since FW might read the BD/SGE right after the producer
491     	 * is updated.
492     	 */
493     	rte_wmb();
494     
>>>     CID 1364784:  Memory - corruptions  (ARRAY_VS_SINGLETON)
>>>     Taking address with "&rx_prods" yields a singleton pointer.
495     	internal_ram_wr(rxq->hw_rxq_prod_addr, sizeof(rx_prods),
496     			(uint32_t *)&rx_prods);
497     
498     	/* mmiowb is needed to synchronize doorbell writes from more than one
499     	 * processor. It guarantees that the write arrives to the device before
500     	 * the napi lock is released and another qede_poll is called (possibly


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8EJnbTgmGI20h61Gmhr-2B3djZK7C-2BMZLryNGk-2FdDTdX-2BMTwtn8TTU-2BuZYFJjIL1jXwBLqBKJIgRp79YQI8zclVcSP9K6tHj-2BhKaOqtIYUbcUTykRQAJmUjWyFxEuaj6WztNSvJR91UZ6-2FLeqZhGBN4C6d5hHmPMfjF1MbGEDSTOKLsGF2We71rn7r1dzakErvKo-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8EJnbTgmGI20h61Gmhr-2B3djZK7C-2BMZLryNGk-2FdDTdX-2BMfZvgbh1Z5PnO7m1UWL28GyahAicsdZkWdouYY0Myo8GRS9Mx3HTdYM2bQ8zPP5QfFGa8-2BzvT9CULCKMvRut2yPO-2F7Pla9-2F4at3wJjdknGz1-2BC-2Bnd9254ixLLWSt38SO3elS9oGIf9f0NjodqleFTBE-3D

