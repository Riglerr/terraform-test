package main

import "testing"

func TestTheMain(t *testing.T) {
	abc := 1
	if abc != 1 {
		t.Errorf("Expected abc to be 1")
	}
}
