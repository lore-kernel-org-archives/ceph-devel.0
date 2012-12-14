From: Nick Bartos <nick@pistoncloud.com>
Subject: Re: rbd map command hangs for 15 minutes during system start up
Date: Fri, 14 Dec 2012 08:53:14 -0800
Message-ID: <CAPud5_7FF=AXMzd4N9kLb4DGQJgp0Csid7_LV3RKYbiTdB+09g@mail.gmail.com>
References: <CA+jddaMAx8OKd8-uHaj-eDx8PJwZB=ew7PkkSAy8Y3Uwm5S85g@mail.gmail.com>
	<CAPud5_6fCfOkXviFB6rz9YvWYBkwNzf699Z1_TW3_v4nCoaUQA@mail.gmail.com>
	<CAPud5_7jXmz9Bz9hAcQKG769wvuCn2eWkV-wc_qEZ7kPdsZf1Q@mail.gmail.com>
	<CAPud5_7P_Z-+14kyGZGxLCUY4SfTWnW3kTOpMh3OYBWgWCt_1w@mail.gmail.com>
	<alpine.DEB.2.00.1211212041240.9963@cobra.newdream.net>
	<CAPud5_4S6-K33f4qLR+-cMm5NLn35H3aXo_LVSenwBM2sxgELg@mail.gmail.com>
	<CAPud5_7EckkvSth8+YeGvEph1GxjTqovXhG6gVWKUX-3K9cLjQ@mail.gmail.com>
	<50B7C788.6040404@inktank.com>
	<50B93FCA.2060801@inktank.com>
	<CAPud5_4avt1ohkdg3s_pcwoF+4AfuAYDP3qJUqL84nFnmh2GjA@mail.gmail.com>
	<50BC2DE6.6050307@inktank.com>
	<50C65AE5.2050704@inktank.com>
	<CAPud5_7OPrpg1Q_UTw2PskG+o=+H82xgJHacmGT+bVOZkf466A@mail.gmail.com>
	<50C774FD.9030107@inktank.com>
	<50C78D09.5050403@inktank.com>
	<CAPud5_697TJpxU_fCe+FzmgeuTxWx61My5p+FJN_2B1fpn_G3Q@mail.gmail.com>
	<CAPud5_6q0gQD0ajpKZdvnaaMBvapQ59fkOA7ANVhPo0dMGJ+Sw@mail.gmail.com>
	<50CB57E2.10703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35131 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224Ab2LNQxX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 11:53:23 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so6207987ieb.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Dec 2012 08:53:22 -0800 (PST)
In-Reply-To: <50CB57E2.10703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, Mandell Degerness <mandell@pistoncloud.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The kernel is 3.5.7 with the following patches applied (and in the
order specified below):

001-libceph_eliminate_connection_state_DEAD_13_days_ago.patch
002-libceph_kill_bad_proto_ceph_connection_op_13_days_ago.patch
003-libceph_rename_socket_callbacks_13_days_ago.patch
004-libceph_rename_kvec_reset_and_kvec_add_functions_13_days_ago.patch
005-libceph_embed_ceph_messenger_structure_in_ceph_client_13_days_ago.patch
006-libceph_start_separating_connection_flags_from_state_13_days_ago.patch
007-libceph_start_tracking_connection_socket_state_13_days_ago.patch
008-libceph_provide_osd_number_when_creating_osd_13_days_ago.patch
009-libceph_set_CLOSED_state_bit_in_con_init_13_days_ago.patch
010-libceph_embed_ceph_connection_structure_in_mon_client_13_days_ago.patch
011-libceph_drop_connection_refcounting_for_mon_client_13_days_ago.patch
012-libceph_init_monitor_connection_when_opening_13_days_ago.patch
013-libceph_fully_initialize_connection_in_con_init_13_days_ago.patch
014-libceph_tweak_ceph_alloc_msg_13_days_ago.patch
015-libceph_have_messages_point_to_their_connection_13_days_ago.patch
016-libceph_have_messages_take_a_connection_reference_13_days_ago.patch
017-libceph_make_ceph_con_revoke_a_msg_operation_13_days_ago.patch
018-libceph_make_ceph_con_revoke_message_a_msg_op_13_days_ago.patch
019-libceph_fix_overflow_in___decode_pool_names_13_days_ago.patch
020-libceph_fix_overflow_in_osdmap_decode_13_days_ago.patch
021-libceph_fix_overflow_in_osdmap_apply_incremental_13_days_ago.patch
022-libceph_transition_socket_state_prior_to_actual_connect_13_days_ago.patch
023-libceph_fix_NULL_dereference_in_reset_connection_13_days_ago.patch
024-libceph_use_con_get_put_methods_13_days_ago.patch
025-libceph_drop_ceph_con_get_put_helpers_and_nref_member_13_days_ago.patch
026-libceph_encapsulate_out_message_data_setup_13_days_ago.patch
027-libceph_encapsulate_advancing_msg_page_13_days_ago.patch
028-libceph_don_t_mark_footer_complete_before_it_is_13_days_ago.patch
029-libceph_move_init_bio__functions_up_13_days_ago.patch
030-libceph_move_init_of_bio_iter_13_days_ago.patch
031-libceph_don_t_use_bio_iter_as_a_flag_13_days_ago.patch
032-libceph_SOCK_CLOSED_is_a_flag_not_a_state_13_days_ago.patch
033-libceph_don_t_change_socket_state_on_sock_event_13_days_ago.patch
034-libceph_just_set_SOCK_CLOSED_when_state_changes_13_days_ago.patch
035-libceph_don_t_touch_con_state_in_con_close_socket_13_days_ago.patch
036-libceph_clear_CONNECTING_in_ceph_con_close_13_days_ago.patch
037-libceph_clear_NEGOTIATING_when_done_13_days_ago.patch
038-libceph_define_and_use_an_explicit_CONNECTED_state_13_days_ago.patch
039-libceph_separate_banner_and_connect_writes_13_days_ago.patch
040-libceph_distinguish_two_phases_of_connect_sequence_13_days_ago.patch
041-libceph_small_changes_to_messenger.c_13_days_ago.patch
042-libceph_add_some_fine_ASCII_art_13_days_ago.patch
043-libceph_set_peer_name_on_con_open_not_init_13_days_ago.patch
044-libceph_initialize_mon_client_con_only_once_13_days_ago.patch
045-libceph_allow_sock_transition_from_CONNECTING_to_CLOSED_13_days_ago.patch
046-libceph_initialize_msgpool_message_types_13_days_ago.patch
047-libceph_prevent_the_race_of_incoming_work_during_teardown_13_days_ago.patch
048-libceph_report_socket_read_write_error_message_13_days_ago.patch
049-libceph_fix_mutex_coverage_for_ceph_con_close_13_days_ago.patch
050-libceph_resubmit_linger_ops_when_pg_mapping_changes_12_days_ago.patch
051-libceph_re_initialize_bio_iter_on_start_of_message_receive_28_hours_ago.patch
052-libceph_protect_ceph_con_open_with_mutex_28_hours_ago.patch
053-libceph_reset_connection_retry_on_successfully_negotiation_28_hours_ago.patch
054-libceph_fix_fault_locking_close_socket_on_lossy_fault_28_hours_ago.patch
055-libceph_move_msgr_clear_standby_under_con_mutex_protection_28_hours_ago.patch
056-libceph_move_ceph_con_send_closed_check_under_the_con_mutex_28_hours_ago.patch
057-libceph_drop_gratuitous_socket_close_calls_in_con_work_28_hours_ago.patch
058-libceph_close_socket_directly_from_ceph_con_close_28_hours_ago.patch
059-libceph_drop_unnecessary_CLOSED_check_in_socket_state_change_callback_28_hours_ago.patch
060-libceph_replace_connection_state_bits_with_states_28_hours_ago.patch
061-libceph_clean_up_con_flags_28_hours_ago.patch
062-libceph_clear_all_flags_on_con_close_28_hours_ago.patch
063-libceph_fix_handling_of_immediate_socket_connect_failure_28_hours_ago.patch
064-libceph_revoke_mon_client_messages_on_session_restart_28_hours_ago.patch
065-libceph_verify_state_after_retaking_con_lock_after_dispatch_28_hours_ago.patch
066-libceph_avoid_dropping_con_mutex_before_fault_28_hours_ago.patch
067-libceph_change_ceph_con_in_msg_alloc_convention_to_be_less_weird_28_hours_ago.patch
068-libceph_recheck_con_state_after_allocating_incoming_message_28_hours_ago.patch
069-libceph_fix_crypto_key_null_deref_memory_leak_28_hours_ago.patch
070-libceph_delay_debugfs_initialization_until_we_learn_global_id_28_hours_ago.patch
071-libceph_avoid_truncation_due_to_racing_banners_28_hours_ago.patch
072-libceph_only_kunmap_kmapped_pages_28_hours_ago.patch
073-rbd_reset_BACKOFF_if_unable_to_re-queue_28_hours_ago.patch
074-libceph_avoid_NULL_kref_put_when_osd_reset_races_with_alloc_msg_28_hours_ago.patch
075-ceph_fix_dentry_reference_leak_in_encode_fh_28_hours_ago.patch
076-ceph_Fix_oops_when_handling_mdsmap_that_decreases_max_mds_28_hours_ago.patch
077-libceph_check_for_invalid_mapping_28_hours_ago.patch
078-ceph_avoid_32-bit_page_index_overflow_28_hours_ago.patch
079-libceph_define_ceph_extract_encoded_string_28_hours_ago.patch
080-rbd_define_some_new_format_constants_28_hours_ago.patch
081-rbd_define_rbd_dev_image_id_28_hours_ago.patch
082-rbd_kill_create_snap_sysfs_entry_28_hours_ago.patch
083-libceph_remove_osdtimeout_option_28_hours_ago.patch
084-ceph_don_t_reference_req_after_put_28_hours_ago.patch
085-libceph_avoid_using_freed_osd_in___kick_osd_requests_28_hours_ago.patch
086-libceph_register_request_before_unregister_linger_28_hours_ago.patch
087-libceph_socket_can_close_in_any_connection_state_28_hours_ago.patch
088-libceph_init_osd-_o_node_in_create_osd_28_hours_ago.patch
089-rbd_remove_linger_unconditionally_28_hours_ago.patch
090-HEAD_ceph_wip-nick-newer_libceph_reformat___reset_osd_28_hours_ago.patch
linux-3.4.4-ignoresync-hack.patch

Yes I was only enabling debugging for libceph.  I'm adding debugging
for rbd as well.  I'll do a repro later today when a test cluster
opens up.


On Fri, Dec 14, 2012 at 8:46 AM, Alex Elder <elder@inktank.com> wrote:
> On 12/13/2012 01:00 PM, Nick Bartos wrote:
>> Here's another log with the kernel debugging enabled:
>> https://gist.github.com/raw/4278697/1c9e41d275e614783fbbdee8ca5842680f46c249/rbd-hang-1355424455.log
>>
>> Note that it hung on the 2nd try.
>
> Just to make sure I'm working with the right code base, can
> you confirm that you're using a kernel built with the equivalent
> of what's now in the "wip-nick-newer" branch (commit id 1728893)?
>
>
> Also, looking at this log I don't think I see any rbd debug output.
> Does that make sense to you?
>
> How are you activating debugging to get these messages?
> If it includes something like:
>
>     echo module libceph +p > /sys/kernel/debug/dynamic_debug/control
>
> it might be that you need to also do:
>
>     echo module rbd +p > /sys/kernel/debug/dynamic_debug/control
>
> This information would be helpful in providing some more context
> about what rbd is doing that's leading to the various messaging
> activity I seen in this log.
>
> Please send me a log with that info if you are able to produce
> one.  Thanks a lot.
>
>                                         -Alex
