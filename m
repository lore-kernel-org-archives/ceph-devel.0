From: Sage Weil <sage@newdream.net>
Subject: Re: coding style document
Date: Thu, 14 Jul 2011 11:02:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107141056250.29636@cobra.newdream.net>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
 <CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
 <CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
 <CA+qbEUOvPqv8r1+LG5ygi8dH5-Cw0+FJnVsnSfamW0N6R1kkUA@mail.gmail.com>
 <CAC-hyiE9XDTE99wox3e3-hL+eF40TyRUhfJ=kv4R_UtZcggG+g@mail.gmail.com>
 <CA+qbEUO9XRPaWnSjv3Exh1TppD7OLNZa=TsZdQKyju+G07x_Bg@mail.gmail.com>
 <CAC-hyiEx2itZ5_RtZ1XhPsPtnF7w0aockQ9+5ZDnzUGooVVdqA@mail.gmail.com>
 <CA+qbEUM7HPo9DdjyS_7Dnmq74u_gKVCJjXEf8G=_VVfiX_sJ-Q@mail.gmail.com>
 <CAC-hyiFxqSEVm5r54hitYWNaHr3DMZ1jyC4FdnCPVDqgFWdULQ@mail.gmail.com>
 <Pine.LNX.4.64.1107131518300.11118@cobra.newdream.net>
 <CAF3hT9CPjOoup+UsWq4MsvxCD4zZPSL1Wu1wWnL1u=G=fJ3e9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47350 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431Ab1GNR7h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2011 13:59:37 -0400
In-Reply-To: <CAF3hT9CPjOoup+UsWq4MsvxCD4zZPSL1Wu1wWnL1u=G=fJ3e9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Colin Patrick McCabe <colin.mccabe@dreamhost.com>, ceph-devel@vger.kernel.org

We just talked about this and the decisions seem to be:

- for naked classes/structs (simple data containers), use a _d suffix 
instead of _t.  e.g.,

struct my_thing_d {
  uint64_t foo;
  uint32_t bar;
  string name;

  my_thing_d() : foo(0), bar(0) {}

  void encode(bufferlist& bl) const {
    ::encode(foo, bl);
    ::encode(bar, bl);
    ::encode(name, bl);
  }
  void decode(bufferlist::iterator& bl) {
    ::decode(foo, bl);
    ::decode(bar, bl);
    ::decode(name, bl);
  }
};
WRITE_CLASS_ENCODER(my_thing_d)

- for full-blown classes with private members, use m_ prefix.  e.g.

+        class Foo {
+	 public:
+          int get_foo() const { return m_foo; }
+          void set_foo(int foo) { m_foo = foo; }
+
+         private:
+          int m_foo;
+   	};

- for simple ifs,

if (foo) bar;    // bad

if (foo)
  bar;           // better

if (foo) {
  bar;           // best
}

The docuemnt is in wip-codingstyle, see

    http://ceph.newdream.net/git/?p=ceph.git;a=blob;f=CodingStyle;h=fee53b8c5565f570da9298172c770a33138757d1;hb=refs/heads/wip-codingstyle

Earth shattering, I know.  Any final comments/objections before we move 
on?  I'm planning a big cleanup of the userspace Client code next week and 
will be apply the style there.

sage
