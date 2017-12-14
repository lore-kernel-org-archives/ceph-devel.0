From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 14 Dec 2017 06:49:49 +0000 (UTC)
Message-ID: <5a321f0d891cd_11f93273282449f@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.hv1nn.shared.sendgrid.net ([167.89.100.17]:13930 "EHLO
        o2.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751035AbdLNGtu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 14 Dec 2017 01:49:50 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0004p1sjc2.sendgrid.net (SG) with ESMTP id 771ILtY2T1eqfCyZQc2JFA
        for <ceph-devel@vger.kernel.org>; Thu, 14 Dec 2017 06:49:49.591 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

3 new defect(s) introduced to ceph found with Coverity Scan.
9 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 3 of 3 defect(s)


** CID 1426118:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 831 in dump_attrs(ceph::Formatter *, ghobject_t, ceph::buffer::list &)()


________________________________________________________________________________________________________
*** CID 1426118:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 831 in dump_attrs(ceph::Formatter *, ghobject_t, ceph::buffer::list &)()
825         cerr << "\tdata: offset " << ds.offset << " len " << ds.len << std::endl;
826       t->write(coll, hoid, ds.offset, ds.len,  ds.databl);
827       return 0;
828     }
829     
830     int dump_attrs(
>>>     CID 1426118:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter hoid of type "ghobject_t" (size 144 bytes) by value.
831       Formatter *formatter, ghobject_t hoid,
832       bufferlist &bl)
833     {
834       bufferlist::iterator ebliter = bl.begin();
835       attr_section as;
836       as.decode(ebliter);

** CID 1426119:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/mds/Server.cc: 7141 in Server::_rename_prepare(boost::intrusive_ptr<MDRequestImpl> &, EMetaBlob *, ceph::buffer::list *, CDentry *, CDentry *, CDentry *)()


________________________________________________________________________________________________________
*** CID 1426119:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/mds/Server.cc: 7141 in Server::_rename_prepare(boost::intrusive_ptr<MDRequestImpl> &, EMetaBlob *, ceph::buffer::list *, CDentry *, CDentry *, CDentry *)()
7135           force_journal_dest = true;
7136         } else
7137           force_journal_dest = _need_force_journal(srci, false);
7138       }
7139     
7140       bool force_journal_stray = false;
>>>     CID 1426119:  Null pointer dereferences  (FORWARD_NULL)
>>>     Comparing "oldin" to null implies that "oldin" might be null.
7141       if (oldin && oldin->is_dir() && straydn && !straydn->is_auth())
7142         force_journal_stray = _need_force_journal(oldin, true);
7143     
7144       if (linkmerge)
7145         dout(10) << " merging remote and primary links to the same inode" << dendl;
7146       if (silent)

** CID 1426120:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/osdmaptool.cc: 87 in main()
/home/brad/working/src/ceph/src/tools/osdmaptool.cc: 87 in main()
/home/brad/working/src/ceph/src/tools/osdmaptool.cc: 87 in main()


________________________________________________________________________________________________________
*** CID 1426120:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/osdmaptool.cc: 87 in main()
81       if (r < 0) {
82         cerr << "error writing output: " << cpp_strerror(r) << std::endl;
83         exit(1);
84       }
85     }
86     
>>>     CID 1426120:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::length_error" is thrown and never caught.
87     int main(int argc, const char **argv)
88     {
89       vector<const char*> args;
90       argv_to_vec(argc, argv, args);
91       env_to_vec(args);
92     
/home/brad/working/src/ceph/src/tools/osdmaptool.cc: 87 in main()
81       if (r < 0) {
82         cerr << "error writing output: " << cpp_strerror(r) << std::endl;
83         exit(1);
84       }
85     }
86     
>>>     CID 1426120:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::length_error" is thrown and never caught.
87     int main(int argc, const char **argv)
88     {
89       vector<const char*> args;
90       argv_to_vec(argc, argv, args);
91       env_to_vec(args);
92     
/home/brad/working/src/ceph/src/tools/osdmaptool.cc: 87 in main()
81       if (r < 0) {
82         cerr << "error writing output: " << cpp_strerror(r) << std::endl;
83         exit(1);
84       }
85     }
86     
>>>     CID 1426120:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::length_error" is thrown and never caught.
87     int main(int argc, const char **argv)
88     {
89       vector<const char*> args;
90       argv_to_vec(argc, argv, args);
91       env_to_vec(args);
92     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E6x734IutrIY1GtLSiPLVFA94P-2FiabRJ3vrnlk8h3cFZPilPWknxysPBhqbNlnBYUO5jDV8murCl-2B0h2BDzwxMYi-2B2ectnbhQ-2BJmSdVSs05dulJH43gd-2BDJwedI-2B0U7gGR8i13XVH7LWUSgHXeUl62llJ0PpG5kq26Z7-2FBLGeY7Kgi1rdKcWQsYvYMRvOkrE4-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E6x734IutrIY1GtLSiPLVFA94P-2FiabRJ3vrnlk8h3cFdA3WxOSvi-2BD3fVZC-2B4Xtx3YqKYb5-2BsKzBekY-2FznzFfqhaKNjIbH7yHfAfzSm0ooqGebXPB7hAPb8LU7azhtETBuDWB19YQ-2F0NeB6IgZHGb2HseJBU-2BpCppkEptq2vGME5Ww9rty2-2BZ7bojv5Uvh20E-3D

