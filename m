From: "Yan, Zheng" <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph mds laggy and failed assert in function
	replay mds/journal.cc
Date: Sun, 27 Apr 2014 12:04:05 +0800
Message-ID: <CAAM7YAnQBwj=KSSfATeepbWyhOMAVwfoiC2AvkCEZrdPwkY2Ug@mail.gmail.com>
References: <20DBB415DF55354C8FC7AF12F4AE7700132C91@MBX02-TPM.mimos.local>
	<CAPYLRzj2WdT4dGzh+LJ7fNwT4kiSg3ZHoM0ZpdyWG_uat6Qz3w@mail.gmail.com>
	<CAEDpR-sMb4A3f60DDFewb9Bfu3XbeDP1gcSkSc6iJwCZLOUBxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11336c26389fe804f7fe4ab4
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAEDpR-sMb4A3f60DDFewb9Bfu3XbeDP1gcSkSc6iJwCZLOUBxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Jingyuan Luke <jyluke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--001a11336c26389fe804f7fe4ab4
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Apr 26, 2014 at 9:56 AM, Jingyuan Luke <jyluke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Greg,
>
> Actually our cluster is pretty empty, but we suspect we had a temporary
> network disconnection to one of our OSD, not sure if this caused the
> problem.
>
> Anyway we don't mind try the method you mentioned, how can we do that?
>

compile ceph-mds with the attached patch. add a line "mds
wipe_sessions = 1" to the ceph.conf,

Yan, Zheng

> Regards,
> Luke
>
>
> On Saturday, April 26, 2014, Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
>>
>> Hmm, it looks like your on-disk SessionMap is horrendously out of
>> date. Did your cluster get full at some point?
>>
>> In any case, we're working on tools to repair this now but they aren't
>> ready for use yet. Probably the only thing you could do is create an
>> empty sessionmap with a higher version than the ones the journal
>> refers to, but that might have other fallout effects...
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>>
>> On Fri, Apr 25, 2014 at 2:57 AM, Mohd Bazli Ab Karim
>> <bazli.abkarim-YhiXQ1Q1pWA@public.gmane.org> wrote:
>> > More logs. I ran ceph-mds  with debug-mds=20.
>> >
>> > -2> 2014-04-25 17:47:54.839672 7f0d6f3f0700 10 mds.0.journal
>> > EMetaBlob.replay inotable tablev 4316124 <= table 4317932
>> > -1> 2014-04-25 17:47:54.839674 7f0d6f3f0700 10 mds.0.journal
>> > EMetaBlob.replay sessionmap v8632368 -(1|2) == table 7239603 prealloc
>> > [1000041df86~1] used 1000041db9e
>> >   0> 2014-04-25 17:47:54.840733 7f0d6f3f0700 -1 mds/journal.cc: In
>> > function 'void EMetaBlob::replay(MDS*, LogSegment*, MDSlaveUpdate*)' thread
>> > 7f0d6f3f0700 time 2014-04-25 17:47:54.839688 mds/journal.cc: 1303: FAILED
>> > assert(session)
>> >
>> > Please look at the attachment for more details.
>> >
>> > Regards,
>> > Bazli
>> >
>> > From: Mohd Bazli Ab Karim
>> > Sent: Friday, April 25, 2014 12:26 PM
>> > To: 'ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> > Subject: Ceph mds laggy and failed assert in function replay
>> > mds/journal.cc
>> >
>> > Dear Ceph-devel, ceph-users,
>> >
>> > I am currently facing issue with my ceph mds server. Ceph-mds daemon
>> > does not want to bring up back.
>> > Tried running that manually with ceph-mds -i mon01 -d but it shows that
>> > it stucks at failed assert(session) line 1303 in mds/journal.cc and aborted.
>> >
>> > Can someone shed some light in this issue.
>> > ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)
>> >
>> > Let me know if I need to send log with debug enabled.
>> >
>> > Regards,
>> > Bazli
>> >
>> > ________________________________
>> > DISCLAIMER:
>> >
>> >
>> > This e-mail (including any attachments) is for the addressee(s) only and
>> > may be confidential, especially as regards personal data. If you are not the
>> > intended recipient, please note that any dealing, review, distribution,
>> > printing, copying or use of this e-mail is strictly prohibited. If you have
>> > received this email in error, please notify the sender immediately and
>> > delete the original message (including any attachments).
>> >
>> >
>> > MIMOS Berhad is a research and development institution under the purview
>> > of the Malaysian Ministry of Science, Technology and Innovation. Opinions,
>> > conclusions and other information in this e-mail that do not relate to the
>> > official business of MIMOS Berhad and/or its subsidiaries shall be
>> > understood as neither given nor endorsed by MIMOS Berhad and/or its
>> > subsidiaries and neither MIMOS Berhad nor its subsidiaries accepts
>> > responsibility for the same. All liability arising from or in connection
>> > with computer viruses and/or corrupted e-mails is excluded to the fullest
>> > extent permitted by law.
>> >
>> >
>> > ------------------------------------------------------------------
>> > -
>> > -
>> > DISCLAIMER:
>> >
>> > This e-mail (including any attachments) is for the addressee(s)
>> > only and may contain confidential information. If you are not the
>> > intended recipient, please note that any dealing, review,
>> > distribution, printing, copying or use of this e-mail is strictly
>> > prohibited. If you have received this email in error, please notify
>> > the sender  immediately and delete the original message.
>> > MIMOS Berhad is a research and development institution under
>> > the purview of the Malaysian Ministry of Science, Technology and
>> > Innovation. Opinions, conclusions and other information in this e-
>> > mail that do not relate to the official business of MIMOS Berhad
>> > and/or its subsidiaries shall be understood as neither given nor
>> > endorsed by MIMOS Berhad and/or its subsidiaries and neither
>> > MIMOS Berhad nor its subsidiaries accepts responsibility for the
>> > same. All liability arising from or in connection with computer
>> > viruses and/or corrupted e-mails is excluded to the fullest extent
>> > permitted by law.
>> >
>> >
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a11336c26389fe804f7fe4ab4
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ceph-skip-bad-sessionmap-during-journal-replay.patch"
Content-Disposition: attachment;
	filename="0001-ceph-skip-bad-sessionmap-during-journal-replay.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_huht7hn80

RnJvbSA5ODkwODRmOTcwM2FkNmM3NGFkYzMxYWJlZGJiYjBlMzA4NDI1NjgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiWWFuLCBaaGVuZyIgPHpoZW5nLnoueWFuQGludGVsLmNvbT4K
RGF0ZTogU3VuLCAyNyBBcHIgMjAxNCAxMTo1MzoxMyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGNl
cGg6IHNraXAgYmFkIHNlc3Npb25tYXAgZHVyaW5nIGpvdXJuYWwgcmVwbGF5CgpTaWduZWQtb2Zm
LWJ5OiBZYW4sIFpoZW5nIDx6aGVuZy56LnlhbkBpbnRlbC5jb20+Ci0tLQogc3JjL21kcy9qb3Vy
bmFsLmNjIHwgNTkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvc3JjL21kcy9qb3VybmFsLmNjIGIvc3JjL21kcy9qb3VybmFsLmNj
CmluZGV4IDQxYTc5ZjkuLjdjMTk2MzYgMTAwNjQ0Ci0tLSBhL3NyYy9tZHMvam91cm5hbC5jYwor
KysgYi9zcmMvbWRzL2pvdXJuYWwuY2MKQEAgLTEyOTMsMzYgKzEyOTMsNDkgQEAgdm9pZCBFTWV0
YUJsb2I6OnJlcGxheShNRFMgKm1kcywgTG9nU2VnbWVudCAqbG9nc2VnLCBNRFNsYXZlVXBkYXRl
ICpzbGF2ZXVwKQogICAgIGlmIChtZHMtPnNlc3Npb25tYXAudmVyc2lvbiA+PSBzZXNzaW9ubWFw
dikgewogICAgICAgZG91dCgxMCkgPDwgIkVNZXRhQmxvYi5yZXBsYXkgc2Vzc2lvbm1hcCB2ICIg
PDwgc2Vzc2lvbm1hcHYKIAkgICAgICAgPDwgIiA8PSB0YWJsZSAiIDw8IG1kcy0+c2Vzc2lvbm1h
cC52ZXJzaW9uIDw8IGRlbmRsOwotICAgIH0gZWxzZSB7Ci0gICAgICBkb3V0KDEwKSA8PCAiRU1l
dGFCbG9iLnJlcGxheSBzZXNzaW9ubWFwIHYiIDw8IHNlc3Npb25tYXB2CisgICAgfSBlbHNlIGlm
IChtZHMtPnNlc3Npb25tYXAudmVyc2lvbiArIDIgPj0gc2Vzc2lvbm1hcHYpIHsKKyAgICAgIGRv
dXQoMTApIDw8ICJFTWV0YUJsb2IucmVwbGF5IHNlc3Npb25tYXAgdiAiIDw8IHNlc3Npb25tYXB2
CiAJICAgICAgIDw8ICIgLSgxfDIpID09IHRhYmxlICIgPDwgbWRzLT5zZXNzaW9ubWFwLnZlcnNp
b24KIAkgICAgICAgPDwgIiBwcmVhbGxvYyAiIDw8IHByZWFsbG9jYXRlZF9pbm9zCiAJICAgICAg
IDw8ICIgdXNlZCAiIDw8IHVzZWRfcHJlYWxsb2NhdGVkX2lubwogCSAgICAgICA8PCBkZW5kbDsK
ICAgICAgIFNlc3Npb24gKnNlc3Npb24gPSBtZHMtPnNlc3Npb25tYXAuZ2V0X3Nlc3Npb24oY2xp
ZW50X25hbWUpOwotICAgICAgYXNzZXJ0KHNlc3Npb24pOwotICAgICAgZG91dCgyMCkgPDwgIiAo
c2Vzc2lvbiBwcmVhbGxvYyAiIDw8IHNlc3Npb24tPmluZm8ucHJlYWxsb2NfaW5vcyA8PCAiKSIg
PDwgZGVuZGw7Ci0gICAgICBpZiAodXNlZF9wcmVhbGxvY2F0ZWRfaW5vKSB7Ci0JaWYgKHNlc3Np
b24tPmluZm8ucHJlYWxsb2NfaW5vcy5lbXB0eSgpKSB7Ci0JICAvLyBIUk06IGJhZG5lc3MgaW4g
dGhlIGpvdXJuYWwKLQkgIG1kcy0+Y2xvZy53YXJuKCkgPDwgIiByZXBsYXllZCBvcCAiIDw8IGNs
aWVudF9yZXFzIDw8ICIgb24gc2Vzc2lvbiBmb3IgIiA8PCBjbGllbnRfbmFtZQotCQkJICAgPDwg
IiB3aXRoIGVtcHR5IHByZWFsbG9jX2lub3NcbiI7Ci0JfSBlbHNlIHsKLQkgIGlub2Rlbm9fdCBu
ZXh0ID0gc2Vzc2lvbi0+bmV4dF9pbm8oKTsKLQkgIGlub2Rlbm9fdCBpID0gc2Vzc2lvbi0+dGFr
ZV9pbm8odXNlZF9wcmVhbGxvY2F0ZWRfaW5vKTsKLQkgIGlmIChuZXh0ICE9IGkpCi0JICAgIG1k
cy0+Y2xvZy53YXJuKCkgPDwgIiByZXBsYXllZCBvcCAiIDw8IGNsaWVudF9yZXFzIDw8ICIgdXNl
ZCBpbm8gIiA8PCBpCi0JCQkgICAgIDw8ICIgYnV0IHNlc3Npb24gbmV4dCBpcyAiIDw8IG5leHQg
PDwgIlxuIjsKLQkgIGFzc2VydChpID09IHVzZWRfcHJlYWxsb2NhdGVkX2lubyk7Ci0JICBzZXNz
aW9uLT5pbmZvLnVzZWRfaW5vcy5jbGVhcigpOworICAgICAgaWYgKHNlc3Npb24pIHsKKwlkb3V0
KDIwKSA8PCAiIChzZXNzaW9uIHByZWFsbG9jICIgPDwgc2Vzc2lvbi0+aW5mby5wcmVhbGxvY19p
bm9zIDw8ICIpIiA8PCBkZW5kbDsKKwlpZiAodXNlZF9wcmVhbGxvY2F0ZWRfaW5vKSB7CisJICBp
ZiAoc2Vzc2lvbi0+aW5mby5wcmVhbGxvY19pbm9zLmVtcHR5KCkpIHsKKwkgICAgLy8gSFJNOiBi
YWRuZXNzIGluIHRoZSBqb3VybmFsCisJICAgIG1kcy0+Y2xvZy53YXJuKCkgPDwgIiByZXBsYXll
ZCBvcCAiIDw8IGNsaWVudF9yZXFzIDw8ICIgb24gc2Vzc2lvbiBmb3IgIgorCQkJICAgICA8PCBj
bGllbnRfbmFtZSA8PCAiIHdpdGggZW1wdHkgcHJlYWxsb2NfaW5vc1xuIjsKKwkgIH0gZWxzZSB7
CisJICAgIGlub2Rlbm9fdCBuZXh0ID0gc2Vzc2lvbi0+bmV4dF9pbm8oKTsKKwkgICAgaW5vZGVu
b190IGkgPSBzZXNzaW9uLT50YWtlX2lubyh1c2VkX3ByZWFsbG9jYXRlZF9pbm8pOworCSAgICBp
ZiAobmV4dCAhPSBpKQorCSAgICAgIG1kcy0+Y2xvZy53YXJuKCkgPDwgIiByZXBsYXllZCBvcCAi
IDw8IGNsaWVudF9yZXFzIDw8ICIgdXNlZCBpbm8gIiA8PCBpCisJCQkgICAgICAgPDwgIiBidXQg
c2Vzc2lvbiBuZXh0IGlzICIgPDwgbmV4dCA8PCAiXG4iOworCSAgICBhc3NlcnQoaSA9PSB1c2Vk
X3ByZWFsbG9jYXRlZF9pbm8pOworCSAgICBzZXNzaW9uLT5pbmZvLnVzZWRfaW5vcy5jbGVhcigp
OworCSAgfQorCSAgbWRzLT5zZXNzaW9ubWFwLnByb2plY3RlZCA9ICsrbWRzLT5zZXNzaW9ubWFw
LnZlcnNpb247CiAJfQotCW1kcy0+c2Vzc2lvbm1hcC5wcm9qZWN0ZWQgPSArK21kcy0+c2Vzc2lv
bm1hcC52ZXJzaW9uOwotICAgICAgfQotICAgICAgaWYgKHByZWFsbG9jYXRlZF9pbm9zLnNpemUo
KSkgewotCXNlc3Npb24tPmluZm8ucHJlYWxsb2NfaW5vcy5pbnNlcnQocHJlYWxsb2NhdGVkX2lu
b3MpOwotCW1kcy0+c2Vzc2lvbm1hcC5wcm9qZWN0ZWQgPSArK21kcy0+c2Vzc2lvbm1hcC52ZXJz
aW9uOworCWlmIChwcmVhbGxvY2F0ZWRfaW5vcy5zaXplKCkpIHsKKwkgIHNlc3Npb24tPmluZm8u
cHJlYWxsb2NfaW5vcy5pbnNlcnQocHJlYWxsb2NhdGVkX2lub3MpOworCSAgbWRzLT5zZXNzaW9u
bWFwLnByb2plY3RlZCA9ICsrbWRzLT5zZXNzaW9ubWFwLnZlcnNpb247CisJfQorCWFzc2VydChz
ZXNzaW9ubWFwdiA9PSBtZHMtPnNlc3Npb25tYXAudmVyc2lvbik7CisgICAgICB9IGVsc2Ugewor
CW1kcy0+Y2xvZy53YXJuKCkgPDwgIiByZXBsYXllZCBvcCAiIDw8IGNsaWVudF9yZXFzIDw8ICIg
bm8gc2Vzc2lvbiBmb3IgIgorCQkJIDw8IGNsaWVudF9uYW1lIDw8ICJcbiI7CisJbWRzLT5zZXNz
aW9ubWFwLnZlcnNpb24gPSBzZXNzaW9ubWFwdjsKKwltZHMtPnNlc3Npb25tYXAucHJvamVjdGVk
ID0gc2Vzc2lvbm1hcHY7CiAgICAgICB9Ci0gICAgICBhc3NlcnQoc2Vzc2lvbm1hcHYgPT0gbWRz
LT5zZXNzaW9ubWFwLnZlcnNpb24pOworICAgIH0gZWxzZSB7CisgICAgICBtZHMtPmNsb2cuZXJy
b3IoKSA8PCAiam91cm5hbCByZXBsYXkgc2Vzc2lvbm1hcCB2ICIgPDwgc2Vzc2lvbm1hcHYKKwkJ
CTw8ICIgLSgxfDIpID4gdGFibGUgIiA8PCBtZHMtPnNlc3Npb25tYXAudmVyc2lvbiA8PCAiXG4i
OworICAgICAgYXNzZXJ0KGdfY29uZi0+bWRzX3dpcGVfc2Vzc2lvbnMpOworICAgICAgbWRzLT5z
ZXNzaW9ubWFwLndpcGUoKTsKKyAgICAgIG1kcy0+c2Vzc2lvbm1hcC52ZXJzaW9uID0gc2Vzc2lv
bm1hcHY7CisgICAgICBtZHMtPnNlc3Npb25tYXAucHJvamVjdGVkID0gc2Vzc2lvbm1hcHY7CiAg
ICAgfQogICB9CiAKLS0gCjEuOS4wCgo=
--001a11336c26389fe804f7fe4ab4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--001a11336c26389fe804f7fe4ab4--
