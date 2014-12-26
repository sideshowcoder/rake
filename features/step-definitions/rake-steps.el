(Given "^I have Rakefile with content:$"
       (lambda (content)
         (find-file (concat rake-test-app-path "/Rakefile"))
         (When "I clear the buffer")
         (When "I insert:" content)
         (save-buffer)))

(Given "^I have Gemfile$"
       (lambda ()
         (f-touch (concat rake-test-app-path "/Gemfile"))))

(When "^I run command \"\\(.+\\)\" \\(?:selecting\\|inputting\\) \"\\(.+\\)\"$"
  (lambda (command argument)
    (When "I start an action chain")
    (When "I press \"M-x\"")
    (And (s-lex-format "I type \"${command}\""))
    (When "I press \"RET\"")
    (And (s-lex-format "I type \"${argument}\""))
    (And "I execute the action chain")))

(Given "^spring is running"
  (lambda ()
    (f-touch rake-test-spring-pid-file)))

(Given "^zeus is running"
  (lambda ()
    (f-touch rake-test-zeus-pid-file)))

(And "^the task \"\\(.+\\)\" is in the cache$"
  (lambda (name)
    (let ((tasks (gethash rake-test-app-path (rake--unserialize-cache))))
      (should (equal (list name) tasks)))))

(And "^the task \"\\(.+\\)\" is not in the cache$"
  (lambda (name)
    (let ((tasks (gethash rake-test-app-path (rake--unserialize-cache))))
      (should (not (equal (list name) tasks))))))

(Given "^I enable the cache$"
  (lambda ()
    (setq rake-enable-caching t)))

(And "I debug"
  (lambda ()
    (print (buffer-string))))
