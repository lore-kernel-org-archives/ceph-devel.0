From: Alex Elder <elder@inktank.com>
Subject: Re: rbd map command hangs for 15 minutes during system start up
Date: Fri, 30 Nov 2012 13:10:46 -0600
Message-ID: <50B904B6.4070400@inktank.com>
References: <CA+jddaMAx8OKd8-uHaj-eDx8PJwZB=ew7PkkSAy8Y3Uwm5S85g@mail.gmail.com> <alpine.DEB.2.00.1211161421350.26514@cobra.newdream.net> <CAPud5_7GXtKn4G4GW+DWA7iFZHub8=hMWxnYfko=u9x+bKgQ6A@mail.gmail.com> <CAPYLRzj=i-cvOQJdUTbGtkjjAr6H4ohwbGe3Qnm1nYPwAjjLJA@mail.gmail.com> <CAPud5_6vGTpPVDATu6U_X5urkXpM5vhDXg3E5MbPu-07MTGuxQ@mail.gmail.com> <CAPud5_4hSU9j5+6EL2VWDuZW0xfFNLCo-_KvDcWDkm9H2pd21w@mail.gmail.com> <alpine.DEB.2.00.1211210849060.1082@cobra.newdream.net> <CAPud5_6fCfOkXviFB6rz9YvWYBkwNzf699Z1_TW3_v4nCoaUQA@mail.gmail.com> <CAPud5_7jXmz9Bz9hAcQKG769wvuCn2eWkV-wc_qEZ7kPdsZf1Q@mail.gmail.com> <CAPud5_7P_Z-+14kyGZGxLCUY4SfTWnW3kTOpMh3OYBWgWCt_1w@mail.gmail.com> <alpine.DEB.2.00.1211212041240.9963@cobra.newdream.net> <CAPud5_4S6-K33f4qLR+-cMm5NLn35H3aXo_LVSenwBM2sxgELg@mail.gmail.com
 > <CAPud5_7EckkvSth8+YeGvEph1GxjTqovXhG6gVWKUX-3K9cLjQ@mail.gmail.com> <50B7C788.6040404@inktank.com> <CAPud5_6-+UGRTgzumGAvjGUPUBj5-XkHKo-RGCkXrNusFuABDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55315 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768807Ab2K3TKs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Nov 2012 14:10:48 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so1167949ieb.19
        for <ceph-devel@vger.kernel.org>; Fri, 30 Nov 2012 11:10:48 -0800 (PST)
In-Reply-To: <CAPud5_6-+UGRTgzumGAvjGUPUBj5-XkHKo-RGCkXrNusFuABDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, Mandell Degerness <mandell@pistoncloud.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/30/2012 12:49 PM, Nick Bartos wrote:
> My initial tests using a 3.5.7 kernel with the 55 patches from
> wip-nick are going well.  So far I've gone through 8 installs without
> an incident, I'll leave it run for a bit longer to see if it crops up
> again.

This is great news!  Now I wonder which of the two fixes took
care of the problem...

> Can I get a branch with these patches integrated into all of the
> backported patches to 3.5.x?  I'd like to get this into our main
> testing branch, which is currently running 3.5.7 with the patches from
> wip-3.5 excluding the
> libceph_resubmit_linger_ops_when_pg_mapping_changes patch.

I will put together a new branch that includes the remainder
of those patches for you shortly.

> Note that we had a case of a rbd map hang with our main testing
> branch, but I don't have a script that can reproduce that yet.  It was
> after the cluster was all up and working, and we were  doing a rolling
> reboot (cycling through each node).

If you are able to reproduce this please let us know.

					-Alex

> 
> 
> On Thu, Nov 29, 2012 at 12:37 PM, Alex Elder <elder@inktank.com> wrote:
>> On 11/22/2012 12:04 PM, Nick Bartos wrote:
>>> Here are the ceph log messages (including the libceph kernel debug
>>> stuff you asked for) from a node boot with the rbd command hung for a
>>> couple of minutes:
>>
>> Nick, I have put together a branch that includes two fixes
>> that might be helpful.  I don't expect these fixes will
>> necessarily *fix* what you're seeing, but one of them
>> pulls a big hunk of processing out of the picture and
>> might help eliminate some potential causes.  I had to
>> pull in several other patches as prerequisites in order
>> to get those fixes to apply cleanly.
>>
>> Would you be able to give it a try, and let us know what
>> results you get?  The branch contains:
>> - Linux 3.5.5
>> - Plus the first 49 patches you listed
>> - Plus four patches, which are prerequisites...
>>     libceph: define ceph_extract_encoded_string()
>>     rbd: define some new format constants
>>     rbd: define rbd_dev_image_id()
>>     rbd: kill create_snap sysfs entry
>> - ...for these two bug fixes:
>>     libceph: remove 'osdtimeout' option
>>     ceph: don't reference req after put
>>
>> The branch is available in the ceph-client git repository
>> under the name "wip-nick" and has commit id dd9323aa.
>>     https://github.com/ceph/ceph-client/tree/wip-nick
>>
>>> https://raw.github.com/gist/4132395/7cb5f0150179b012429c6e57749120dd88616cce/gistfile1.txt
>>
>> This full debug output is very helpful.  Please supply
>> that again as well.
>>
>> Thanks.
>>
>>                                         -Alex
>>
>>> On Wed, Nov 21, 2012 at 9:49 PM, Nick Bartos <nick@pistoncloud.com> wrote:
>>>> It's very easy to reproduce now with my automated install script, the
>>>> most I've seen it succeed with that patch is 2 in a row, and hanging
>>>> on the 3rd, although it hangs on most builds.  So it shouldn't take
>>>> much to get it to do it again.  I'll try and get to that tomorrow,
>>>> when I'm a bit more rested and my brain is working better.
>>>>
>>>> Yes during this the OSDs are probably all syncing up.  All the osd and
>>>> mon daemons have started by the time the rdb commands are ran, though.
>>>>
>>>> On Wed, Nov 21, 2012 at 8:47 PM, Sage Weil <sage@inktank.com> wrote:
>>>>> On Wed, 21 Nov 2012, Nick Bartos wrote:
>>>>>> FYI the build which included all 3.5 backports except patch #50 is
>>>>>> still going strong after 21 builds.
>>>>>
>>>>> Okay, that one at least makes some sense.  I've opened
>>>>>
>>>>>         http://tracker.newdream.net/issues/3519
>>>>>
>>>>> How easy is this to reproduce?  If it is something you can trigger with
>>>>> debugging enabled ('echo module libceph +p >
>>>>> /sys/kernel/debug/dynamic_debug/control') that would help tremendously.
>>>>>
>>>>> I'm guessing that during this startup time the OSDs are still in the
>>>>> process of starting?
>>>>>
>>>>> Alex, I bet that a test that does a lot of map/unmap stuff in a loop while
>>>>> thrashing OSDs could hit this.
>>>>>
>>>>> Thanks!
>>>>> sage
>>>>>
>>>>>
>>>>>>
>>>>>> On Wed, Nov 21, 2012 at 9:34 AM, Nick Bartos <nick@pistoncloud.com> wrote:
>>>>>>> With 8 successful installs already done, I'm reasonably confident that
>>>>>>> it's patch #50.  I'm making another build which applies all patches
>>>>>>> from the 3.5 backport branch, excluding that specific one.  I'll let
>>>>>>> you know if that turns up any unexpected failures.
>>>>>>>
>>>>>>> What will the potential fall out be for removing that specific patch?
>>>>>>>
>>>>>>>
>>>>>>> On Wed, Nov 21, 2012 at 9:02 AM, Nick Bartos <nick@pistoncloud.com> wrote:
>>>>>>>> It's really looking like it's the
>>>>>>>> libceph_resubmit_linger_ops_when_pg_mapping_changes commit.  When
>>>>>>>> patches 1-50 (listed below) are applied to 3.5.7, the hang is present.
>>>>>>>>  So far I have gone through 4 successful installs with no hang with
>>>>>>>> only 1-49 applied.  I'm still leaving my test run to make sure it's
>>>>>>>> not a fluke, but since previously it hangs within the first couple of
>>>>>>>> builds, it really looks like this is where the problem originated.
>>>>>>>>
>>>>>>>> 1-libceph_eliminate_connection_state_DEAD.patch
>>>>>>>> 2-libceph_kill_bad_proto_ceph_connection_op.patch
>>>>>>>> 3-libceph_rename_socket_callbacks.patch
>>>>>>>> 4-libceph_rename_kvec_reset_and_kvec_add_functions.patch
>>>>>>>> 5-libceph_embed_ceph_messenger_structure_in_ceph_client.patch
>>>>>>>> 6-libceph_start_separating_connection_flags_from_state.patch
>>>>>>>> 7-libceph_start_tracking_connection_socket_state.patch
>>>>>>>> 8-libceph_provide_osd_number_when_creating_osd.patch
>>>>>>>> 9-libceph_set_CLOSED_state_bit_in_con_init.patch
>>>>>>>> 10-libceph_embed_ceph_connection_structure_in_mon_client.patch
>>>>>>>> 11-libceph_drop_connection_refcounting_for_mon_client.patch
>>>>>>>> 12-libceph_init_monitor_connection_when_opening.patch
>>>>>>>> 13-libceph_fully_initialize_connection_in_con_init.patch
>>>>>>>> 14-libceph_tweak_ceph_alloc_msg.patch
>>>>>>>> 15-libceph_have_messages_point_to_their_connection.patch
>>>>>>>> 16-libceph_have_messages_take_a_connection_reference.patch
>>>>>>>> 17-libceph_make_ceph_con_revoke_a_msg_operation.patch
>>>>>>>> 18-libceph_make_ceph_con_revoke_message_a_msg_op.patch
>>>>>>>> 19-libceph_fix_overflow_in___decode_pool_names.patch
>>>>>>>> 20-libceph_fix_overflow_in_osdmap_decode.patch
>>>>>>>> 21-libceph_fix_overflow_in_osdmap_apply_incremental.patch
>>>>>>>> 22-libceph_transition_socket_state_prior_to_actual_connect.patch
>>>>>>>> 23-libceph_fix_NULL_dereference_in_reset_connection.patch
>>>>>>>> 24-libceph_use_con_get_put_methods.patch
>>>>>>>> 25-libceph_drop_ceph_con_get_put_helpers_and_nref_member.patch
>>>>>>>> 26-libceph_encapsulate_out_message_data_setup.patch
>>>>>>>> 27-libceph_encapsulate_advancing_msg_page.patch
>>>>>>>> 28-libceph_don_t_mark_footer_complete_before_it_is.patch
>>>>>>>> 29-libceph_move_init_bio__functions_up.patch
>>>>>>>> 30-libceph_move_init_of_bio_iter.patch
>>>>>>>> 31-libceph_don_t_use_bio_iter_as_a_flag.patch
>>>>>>>> 32-libceph_SOCK_CLOSED_is_a_flag_not_a_state.patch
>>>>>>>> 33-libceph_don_t_change_socket_state_on_sock_event.patch
>>>>>>>> 34-libceph_just_set_SOCK_CLOSED_when_state_changes.patch
>>>>>>>> 35-libceph_don_t_touch_con_state_in_con_close_socket.patch
>>>>>>>> 36-libceph_clear_CONNECTING_in_ceph_con_close.patch
>>>>>>>> 37-libceph_clear_NEGOTIATING_when_done.patch
>>>>>>>> 38-libceph_define_and_use_an_explicit_CONNECTED_state.patch
>>>>>>>> 39-libceph_separate_banner_and_connect_writes.patch
>>>>>>>> 40-libceph_distinguish_two_phases_of_connect_sequence.patch
>>>>>>>> 41-libceph_small_changes_to_messenger.c.patch
>>>>>>>> 42-libceph_add_some_fine_ASCII_art.patch
>>>>>>>> 43-libceph_set_peer_name_on_con_open_not_init.patch
>>>>>>>> 44-libceph_initialize_mon_client_con_only_once.patch
>>>>>>>> 45-libceph_allow_sock_transition_from_CONNECTING_to_CLOSED.patch
>>>>>>>> 46-libceph_initialize_msgpool_message_types.patch
>>>>>>>> 47-libceph_prevent_the_race_of_incoming_work_during_teardown.patch
>>>>>>>> 48-libceph_report_socket_read_write_error_message.patch
>>>>>>>> 49-libceph_fix_mutex_coverage_for_ceph_con_close.patch
>>>>>>>> 50-libceph_resubmit_linger_ops_when_pg_mapping_changes.patch
>>>>>>>>
>>>>>>>>
>>>>>>>> On Wed, Nov 21, 2012 at 8:50 AM, Sage Weil <sage@inktank.com> wrote:
>>>>>>>>> Thanks for hunting this down.  I'm very curious what the culprit is...
>>>>>>>>>
>>>>>>>>> sage
>>>>>>
>>>>>>
>>

